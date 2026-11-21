# reverse-challs

[![Code: MIT](https://img.shields.io/badge/code-MIT-green.svg)](LICENSE)
[![Writeups: CC BY 4.0](https://img.shields.io/badge/writeups-CC%20BY%204.0-lightgrey.svg)](LICENSE-CC-BY-4.0)

A learning log for **reverse engineering**: one challenge at a time, with the
binary, a working copy, and a writeup of how it was solved. The goal is to learn
by doing and to keep notes good enough to come back to months later.

Works on **Linux** and **macOS** (Windows: use WSL).

> **Spoiler alert.** Passwords, license keys and flags are written in
> **plain text** in the writeups. Yes, all of them. If you want to solve a
> challenge yourself, close the writeup and open the binary first. Or don't
> check at all, I'm a README, not a cop.

## Challenges

| # | Challenge | Source | Platform | Notes |
|---|---|---|---|---|
| 001 | really_easy | crackmes.one | ELF x86-64 | ✔ |
| 002 | zexor-v1 | crackmes.one | ELF x86-64 | ✔ |
| 003 | crackme1 | crackmes.one | ELF x86-64 | |
| 004 | eyecandylocked | crackmes.one | ELF x86-64 | |
| 005 | var | crackmes.one | ELF x86-64 | |
| 006 | crackme_de2_1 | crackmes.one | ELF x86 + x86-64 | |
| 007 | vvsc | crackmes.one | ELF x86-64 | |
| 008 | u_cant_pass | crackmes.one | ELF x86-64 | |
| 009 | PieIsMyFav | crackmes.one | ELF x86-64 | |
| 010 | easyAF | crackmes.one | ELF x86-64 | |
| 011 | beginner_friendly | crackmes.one | Mach-O x86-64 | |

✔ = writeup with notes. Empty rows only have the header filled in (name, hash,
file type): the notes come when I solve them.

## Layout

```
reverse-challs/
├── newchall                 create a new challenge
├── install.sh               set up a new machine
├── _template/writeup.md     template for every writeup
└── <source>/                e.g. crackmes.one
    ├── ghidra/              Ghidra project (local only, not in git)
    └── <NNN-name>/
        ├── bin/             original files, read-only, never touched
        ├── work/            writable copy: patch and run things here
        └── writeup.md       notes
```

## Setup

```sh
git clone https://github.com/davidepiolomonaco/reverse-challs.git
cd reverse-challs
./install.sh
```

`install.sh` checks the tools (`bash`, `python3`, `file`, `git`,
`sha256sum`/`shasum`) and links `newchall` into `~/.local/bin`.

Tools I use for the analysis: [Ghidra](https://ghidra-sre.org/),
[gdb](https://www.sourceware.org/gdb/) with
[pwndbg](https://github.com/pwndbg/pwndbg), `strings`, `file`, `checksec`.

## Usage

```sh
newchall crackmes.one 012-easy ~/Downloads/easy   # new challenge
newchall -l                                       # list sources and challenges
newchall --help
```

It creates `bin/` (read-only original) and `work/` (writable copy) and fills the
writeup with name, source, date, SHA256 and file type. It never overwrites an
existing challenge.

Workflow: analyse and patch in `work/`, take notes in `writeup.md`. To start
over: `cp bin/<file> work/<file>`. Write patches (offsets, bytes) in the writeup
so they can be reproduced.

### Writeup format

Every writeup follows [`_template/writeup.md`](_template/writeup.md):
file info, recon, analysis, solution, and what I learned.

### What git tracks

Everything except the Ghidra projects (`ghidra/*.gpr`, `ghidra/*.rep/`): they are
heavy and change at every open. To carry one to another machine, export it from
Ghidra into `<source>/ghidra/export/`, or re-import the binary from `bin/`.

## Safety

- Only legal challenges (crackmes, CTFs, your own binaries).
- **Run unknown binaries inside a VM**, never on your main machine. CTF binaries
  can be real malware.

## Licenses

| What | License |
|---|---|
| Scripts (`newchall`, `install.sh`) | [MIT](LICENSE) |
| Writeups, template and this README | [CC BY 4.0](LICENSE-CC-BY-4.0) |

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](LICENSE-CC-BY-4.0)

**Not covered by these licenses:** the binaries in `bin/` and `work/`. They were
written by other people, are copied from the sources named in the table (for
study and reproducibility), and belong to their authors. If you are an author and
want one removed, open an issue and it will go.
