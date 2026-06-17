#!/usr/bin/env python3
"""Conversor pure-Python de DBF (dBase III / Clipper) para CSV + extração de schema.

Sem dependências externas. Lê o cabeçalho, descritores de campo e registros.
Decodifica texto como cp850 (padrão de sistemas DOS brasileiros legados),
com fallback para latin1.
"""
import os
import sys
import csv
import json
import struct
import glob

TYPE_NAMES = {
    "C": "Character",
    "N": "Numeric",
    "F": "Float",
    "D": "Date",
    "L": "Logical",
    "M": "Memo",
    "T": "DateTime",
    "I": "Integer",
    "B": "Double",
}


def decode(raw: bytes) -> str:
    for enc in ("cp850", "latin1"):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return raw.decode("latin1", errors="replace")


def read_dbf(path):
    with open(path, "rb") as fh:
        header = fh.read(32)
        if len(header) < 32:
            raise ValueError("cabeçalho curto")
        version = header[0]
        num_records = struct.unpack("<I", header[4:8])[0]
        header_size = struct.unpack("<H", header[8:10])[0]
        record_size = struct.unpack("<H", header[10:12])[0]

        # Descritores de campo: blocos de 32 bytes até 0x0D
        fields = []
        while True:
            fd = fh.read(32)
            if not fd or fd[0:1] == b"\x0d":
                break
            if len(fd) < 32:
                break
            name = decode(fd[0:11].split(b"\x00")[0]).strip()
            ftype = chr(fd[11])
            length = fd[16]
            decimals = fd[17]
            if not name:
                continue
            fields.append({"name": name, "type": ftype,
                           "length": length, "decimals": decimals})

        # Posiciona no início dos registros
        fh.seek(header_size)
        rows = []
        deleted = 0
        for _ in range(num_records):
            rec = fh.read(record_size)
            if len(rec) < record_size:
                break
            flag = rec[0:1]
            if flag == b"*":
                deleted += 1
                continue  # registro deletado
            values = {}
            offset = 1
            for f in fields:
                raw = rec[offset:offset + f["length"]]
                offset += f["length"]
                values[f["name"]] = format_value(raw, f)
            rows.append(values)
        return {
            "version": version,
            "num_records": num_records,
            "deleted": deleted,
            "header_size": header_size,
            "record_size": record_size,
            "fields": fields,
            "rows": rows,
        }


def format_value(raw: bytes, field) -> str:
    t = field["type"]
    if t in ("C", "M"):
        return decode(raw).rstrip()
    if t == "N" or t == "F":
        s = decode(raw).strip()
        return s
    if t == "D":
        s = decode(raw).strip()
        if len(s) == 8 and s.isdigit():
            return f"{s[0:4]}-{s[4:6]}-{s[6:8]}"
        return s
    if t == "L":
        s = decode(raw).strip().upper()
        if s in ("T", "Y"):
            return "true"
        if s in ("F", "N"):
            return "false"
        return ""
    return decode(raw).strip()


def convert(path, out_dir):
    name = os.path.splitext(os.path.basename(path))[0].upper()
    try:
        data = read_dbf(path)
    except Exception as e:
        print(f"ERRO {name}: {e}")
        return None
    csv_path = os.path.join(out_dir, f"{name}.csv")
    cols = [f["name"] for f in data["fields"]]
    with open(csv_path, "w", newline="", encoding="utf-8") as out:
        w = csv.DictWriter(out, fieldnames=cols)
        w.writeheader()
        for row in data["rows"]:
            w.writerow(row)
    schema = {
        "table": name,
        "records": len(data["rows"]),
        "deleted": data["deleted"],
        "fields": data["fields"],
    }
    print(f"OK  {name:14s} {len(data['rows']):6d} regs, "
          f"{len(cols):2d} campos -> {os.path.basename(csv_path)}")
    return schema


def main():
    src = os.path.dirname(os.path.abspath(__file__))
    estoque = os.path.join(src, "ESTOQUE")
    out_dir = os.path.join(src, "csv")
    os.makedirs(out_dir, exist_ok=True)

    pattern = sys.argv[1] if len(sys.argv) > 1 else "*.[Dd][Bb][Ff]"
    files = sorted(glob.glob(os.path.join(estoque, pattern)))
    schemas = []
    for f in files:
        s = convert(f, out_dir)
        if s:
            schemas.append(s)
    with open(os.path.join(out_dir, "_schema.json"), "w", encoding="utf-8") as fh:
        json.dump(schemas, fh, indent=2, ensure_ascii=False)
    print(f"\nTotal: {len(schemas)} tabelas convertidas -> {out_dir}")


if __name__ == "__main__":
    main()
