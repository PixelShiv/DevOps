#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

mkdir -p build
cd build

cmake ..
make

echo "✅ Build output:"
ls -lh *.elf *.bin
