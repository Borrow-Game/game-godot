#!/bin/sh
echo -ne '\033c\033]0;BorrowGame\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/BorrowGame.x86_64" "$@"
