#!/usr/bin/env python3

#GZML remake
import sys
import re
import os

MOD_REPLACEMENTS = {
    "mainMod": "SUPER",
    "$mainMod": "SUPER",
}

def split_top_level_args(s):
    args = []
    cur = []
    depth = 0
    quote = None
    i = 0

    while i < len(s):
        c = s[i]

        if quote:
            cur.append(c)
            if c == "\\" and i + 1 < len(s):
                i += 1
                cur.append(s[i])
            elif quote == "]]" and s[i:i+2] == "]]":
                quote = None
            elif c == quote:
                quote = None
            i += 1
            continue

        if s[i:i+2] == "[[":
            quote = "]]"
            cur.append("[[")
            i += 2
            continue

        if c in ("'", '"'):
            quote = c
            cur.append(c)
        elif c == "(":
            depth += 1
            cur.append(c)
        elif c == ")":
            depth -= 1
            cur.append(c)
        elif c == "," and depth == 0:
            args.append("".join(cur).strip())
            cur = []
        else:
            cur.append(c)

        i += 1

    if cur:
        args.append("".join(cur).strip())

    return args

def clean_lua_string(s):
    s = s.strip()

    if s.startswith("[[") and s.endswith("]]"):
        return s[2:-2]

    if len(s) >= 2 and s[0] in ("'", '"') and s[-1] == s[0]:
        return s[1:-1]

    return s

def normalize_mods(mods):
    mods = mods.replace("..", "+")
    mods = clean_lua_string(mods)

    for k, v in MOD_REPLACEMENTS.items():
        mods = re.sub(rf"\b{re.escape(k)}\b", v, mods)

    mods = mods.replace('"', "").replace("'", "")
    mods = mods.replace("+", " + ")
    mods = re.sub(r"\s+", " ", mods).strip()
    mods = mods.replace(" + ", "+")

    return mods

def parse_lua_bind(line):
    line = line.strip()

    if line.startswith("--"):
        return None

    m = re.match(r'^\s*b\((.*)\)\s*,?\s*$', line)
    if not m:
        return None

    args = split_top_level_args(m.group(1))

    if len(args) < 4:
        return None

    mods = normalize_mods(args[0])
    key = clean_lua_string(args[1])
    action = args[2].strip()
    desc = clean_lua_string(args[3])

    combo = f"{mods}+{key}" if mods else key
    combo = combo.replace("++", "+")

    if desc:
        return f"{combo} — {desc}"

    return f"{combo} — {action}"

def parse_conf_bind(line):
    line = line.strip()

    if line.startswith("#"):
        return None

    m = re.match(r'^\s*(bind[a-z]*)\s*=\s*(.*)', line)
    if not m:
        return None

    binder = m.group(1)
    rhs = m.group(2)
    parts = [p.strip() for p in rhs.split(",")]

    if len(parts) < 3:
        return None

    has_desc = binder != "bind" and "d" in binder

    mods = parts[0].replace("$mainMod", "SUPER").replace(" ", "+")
    key = parts[1]

    if has_desc and len(parts) >= 4:
        desc = parts[2]
        return f"{mods}+{key} — {desc}"

    dispatcher = parts[2]
    params = ", ".join(parts[3:]) if len(parts) > 3 else ""

    return f"{mods}+{key} — {dispatcher} {params}".strip()

def parse_file(path):
    out = []

    if not os.path.exists(path):
        return out

    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            parsed = parse_lua_bind(line) or parse_conf_bind(line)
            if parsed:
                out.append(parsed)

    return out

def main():
    files = sys.argv[1:]
    results = []

    for path in files:
        results.extend(parse_file(path))

    if not results:
        print("no keybinds found.")
        sys.exit(1)

    seen = set()
    for line in results:
        if line not in seen:
            print(line)
            seen.add(line)

if __name__ == "__main__":
    main()
