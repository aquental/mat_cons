#!/usr/bin/env python3
"""Carrega os arquivos DBF (dBase III / Clipper) num banco SQLite (data.db).

Lê diretamente dos .DBF em data/ESTOQUE/ (reaproveitando o parser de dbf2csv.py),
cria uma tabela por arquivo com tipos de coluna inferidos e insere os dados.

Uso:
    python3 dbf2sqlite.py                 # núcleo (ignora TMP* e X* backups)
    python3 dbf2sqlite.py --all           # inclui temporários e backups
    python3 dbf2sqlite.py "ESTOQUE.DBF"   # apenas um arquivo (glob)

Mapeamento de tipos DBF -> SQLite:
    C, M           -> TEXT
    N/F  (dec > 0) -> REAL
    N/F  (dec = 0) -> INTEGER
    D              -> TEXT  (YYYY-MM-DD)
    L              -> INTEGER (0/1)
"""
import os
import sys
import glob
import sqlite3

from dbf2csv import read_dbf  # reaproveita o parser pure-Python


def sqlite_type(field):
    t = field["type"]
    if t in ("C", "M", "D"):
        return "TEXT"
    if t in ("N", "F", "B", "I"):
        return "REAL" if field["decimals"] else "INTEGER"
    if t == "L":
        return "INTEGER"
    return "TEXT"


def typed_value(svalue, field):
    """Converte a string formatada do parser para valor tipado do SQLite."""
    t = field["type"]
    if svalue == "" or svalue is None:
        return None
    if t in ("C", "M", "D"):
        return svalue
    if t == "L":
        return 1 if svalue == "true" else 0
    if t in ("N", "F", "B", "I"):
        s = svalue.replace(",", ".").strip()
        if s in ("", "-", "."):
            return None
        try:
            return float(s) if field["decimals"] else int(float(s))
        except ValueError:
            return None  # valor corrompido -> NULL
    return svalue


def load_table(conn, path, all_tables):
    name = os.path.splitext(os.path.basename(path))[0].upper()
    try:
        data = read_dbf(path)
    except Exception as e:
        print(f"ERRO {name}: {e}")
        return 0

    fields = data["fields"]
    cols_ddl = ", ".join(f'"{f["name"]}" {sqlite_type(f)}' for f in fields)
    conn.execute(f'DROP TABLE IF EXISTS "{name}"')
    conn.execute(f'CREATE TABLE "{name}" ({cols_ddl})')

    placeholders = ", ".join("?" for _ in fields)
    col_list = ", ".join(f'"{f["name"]}"' for f in fields)
    insert = f'INSERT INTO "{name}" ({col_list}) VALUES ({placeholders})'

    rows = (
        tuple(typed_value(row.get(f["name"], ""), f) for f in fields)
        for row in data["rows"]
    )
    conn.executemany(insert, rows)
    n = len(data["rows"])
    print(f"OK  {name:14s} {n:6d} regs, {len(fields):2d} colunas")
    return n


def main():
    src = os.path.dirname(os.path.abspath(__file__))
    estoque = os.path.join(src, "ESTOQUE")
    db_path = os.path.join(src, "data.db")

    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    all_tables = "--all" in sys.argv[1:]
    pattern = args[0] if args else "*.[Dd][Bb][Ff]"

    files = sorted(glob.glob(os.path.join(estoque, pattern)))
    if not all_tables:
        files = [
            f for f in files
            if not os.path.basename(f).upper().startswith(("TMP", "X"))
        ]

    if os.path.exists(db_path):
        os.remove(db_path)
    conn = sqlite3.connect(db_path)

    total_rows = 0
    total_tables = 0
    for f in files:
        n = load_table(conn, f, all_tables)
        total_rows += n
        total_tables += 1

    conn.commit()
    conn.execute("VACUUM")
    conn.close()

    size = os.path.getsize(db_path)
    print(f"\n{total_tables} tabelas, {total_rows} registros -> "
          f"{db_path} ({size/1024:.0f} KB)")
    print("Inspecione com:  sqlite3 data/data.db '.tables'")


if __name__ == "__main__":
    main()
