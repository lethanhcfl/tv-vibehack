#!/usr/bin/env bash
# [Update: 26/10/2026 16:22]
# Tương thích và chuyển tiếp gọi update-launcher.sh cho Xiaomi TV A75 Pro
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$DIR/update-launcher.sh" "$@"
