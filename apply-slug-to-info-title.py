#!/usr/bin/env python3
"""Normalize info.title and info.version in every OpenAPI spec under specs/.
Both end up in the mock URL (`/rest/<title>/<version>/<path>`), so anything
that isn't URL-safe in a path segment gets scrubbed to a hyphen.

  - title:   strict slug — lowercase, hyphen-separated, alphanumeric only
             (`^[a-z0-9]+(?:-[a-z0-9]+)*$`).
  - version: URL-safe — alphanumeric, dot, hyphen (`^[A-Za-z0-9.-]+$`). Semver
             like `1.0.0` and dates like `2026-03-05` are left alone; slashes,
             spaces, parens, em-dashes are scrubbed.

Run from the repo root:

    python3 apply-slug-to-info-title.py            # report what would change
    python3 apply-slug-to-info-title.py --write    # rewrite specs in place
"""

from __future__ import annotations

import os
import re
import sys

SPECS_DIR = "specs"
TITLE_SLUG_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
VERSION_SAFE_RE = re.compile(r"^[A-Za-z0-9.-]+$")
TITLE_RE = re.compile(r"^(\s*title:\s*)(.+?)\s*$", re.M)
VERSION_RE = re.compile(r"^(\s*version:\s*)(.+?)\s*$", re.M)


def slugify_title(s: str) -> str:
    s = s.lower()
    s = re.sub(r"[^a-z0-9]+", "-", s)
    s = re.sub(r"-+", "-", s).strip("-")
    return s


def scrub_version(s: str) -> str:
    s = re.sub(r"[^A-Za-z0-9.-]+", "-", s)
    s = re.sub(r"-+", "-", s).strip("-.")
    return s


def normalize(text, regex, conforms, fix):
    """Return (new_text, old_value, new_value). old/new are None if no change."""
    m = regex.search(text)
    if not m:
        return text, None, None
    current = m.group(2).strip().strip("'\"")
    if conforms(current):
        return text, None, None
    new = fix(current)
    new_text = regex.sub(lambda mm: f"{mm.group(1)}{new}", text, count=1)
    return new_text, current, new


def main() -> int:
    write = "--write" in sys.argv
    changes = []  # (path, field, old, new)
    fields = (
        ("title", TITLE_RE, lambda s: bool(TITLE_SLUG_RE.match(s)), slugify_title),
        ("version", VERSION_RE, lambda s: bool(VERSION_SAFE_RE.match(s)), scrub_version),
    )
    for f in sorted(os.listdir(SPECS_DIR)):
        path = os.path.join(SPECS_DIR, f)
        with open(path) as fh:
            text = fh.read()
        original = text
        for field, regex, conforms, fix in fields:
            text, old, new = normalize(text, regex, conforms, fix)
            if old is not None:
                changes.append((path, field, old, new))
        if write and text != original:
            with open(path, "w") as fh:
                fh.write(text)

    if not changes:
        print("All spec titles and versions already conform.")
        return 0

    verb = "rewrote" if write else "would rewrite"
    for path, field, old, new in changes:
        print(f"{verb} {path} info.{field}: {old!r} -> {new!r}")
    print(f"\n{verb} {len(changes)} field(s) across {len({c[0] for c in changes})} spec(s).")
    if not write:
        print("Re-run with --write to apply.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
