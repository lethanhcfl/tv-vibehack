#!/usr/bin/env bash
# [Update: 26/10/2026 16:15]
# Script thực thi vô hiệu hóa (debloat) an toàn cho Xiaomi TV A75 Pro
# Dùng pm disable-user --user 0 (không xóa file APK hệ thống)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

ADB="$PROJECT_ROOT/tools/platform-tools/adb"
if [ ! -x "$ADB" ]; then
    ADB="adb"
fi

DEV="${TV_HOST:-192.168.1.164:5555}"
DEBLOAT_FILE="$SCRIPT_DIR/debloat.txt"

echo "========================================================"
echo " [DEBLOAT] ĐANG TỐI ƯU HÓA AN TOÀN XIAOMI TV A75 PRO "
echo "========================================================"
echo "Thiết bị mục tiêu: $DEV"

"$ADB" connect "$DEV" || true

count=0
if [ -f "$DEBLOAT_FILE" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        pkg="$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        if [ -n "$pkg" ]; then
            echo "   [Vô hiệu hóa] $pkg ..."
            "$ADB" -s "$DEV" shell pm disable-user --user 0 "$pkg" < /dev/null || true
            count=$((count + 1))
        fi
    done < "$DEBLOAT_FILE"
fi

echo "========================================================"
echo " ĐÃ VÔ HIỆU HÓA XONG $count GÓI TIỆN ÍCH RÁC / QUẢNG CÁO "
echo "========================================================"
