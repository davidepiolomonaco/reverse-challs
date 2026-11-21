#!/usr/bin/env bash
# Sets up this repo on a new machine (Linux or macOS):
#   - checks the tools newchall needs
#   - links newchall into ~/.local/bin so it works from any folder
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
BIN="$HOME/.local/bin"
ok=1

need() {
    if command -v "$1" >/dev/null 2>&1; then echo "  ok       $1"
    else echo "  MISSING  $1  ($2)"; ok=0; fi
}
want() {
    if command -v "$1" >/dev/null 2>&1; then echo "  ok       $1"
    else echo "  optional $1  ($2)"; fi
}

case "$(uname -s)" in
    Linux)  os=Linux;  hint_gdb="sudo apt install gdb" ;;
    Darwin) os=macOS;  hint_gdb="brew install gdb (needs codesigning) or use lldb" ;;
    *) echo "Unsupported OS: $(uname -s) (Linux and macOS only)"; exit 1 ;;
esac
echo "System: $os"

echo "Required tools:"
need bash    "bash 3.2 or newer"
need python3 "used by newchall to fill the template"
need file    "detects the binary type"
need git     "to sync the repo"
if command -v sha256sum >/dev/null 2>&1 || command -v shasum >/dev/null 2>&1; then
    echo "  ok       sha256sum/shasum"
else echo "  MISSING  sha256sum or shasum"; ok=0; fi

echo "Optional tools:"
want gdb     "$hint_gdb"
want strings "binutils"

[ "$ok" = 1 ] || { echo; echo "Install the missing tools and run this script again."; exit 1; }

chmod +x "$HERE/newchall"
mkdir -p "$BIN"
ln -sf "$HERE/newchall" "$BIN/newchall"
echo
echo "Linked: $BIN/newchall -> $HERE/newchall"

case ":$PATH:" in
    *":$BIN:"*) echo "Ready: run 'newchall --help'." ;;
    *) echo "Note: $BIN is not in your PATH. Add this line to ~/.bashrc or ~/.zshrc:"
       echo "  export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
esac
