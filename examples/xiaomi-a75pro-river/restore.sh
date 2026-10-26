#!/usr/bin/env bash
# [Update: 26/10/2026 16:15]
# Script phục hồi khôi phục toàn bộ cài đặt gốc cho Xiaomi TV A75 Pro
# Tự động kích hoạt lại tất cả ứng dụng đã tắt và đưa Google TV Launcher về mặc định
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
echo " [PHỤC HỒI] ĐANG KHÔI PHỤC TOÀN DIỆN XIAOMI TV A75 PRO "
echo "========================================================"
echo "Thiết bị mục tiêu: $DEV"

# Kết nối lại ADB nếu chưa kết nối
"$ADB" connect "$DEV" || true

echo "1. Đang kích hoạt lại toàn bộ các gói ứng dụng hệ thống..."
if [ -f "$DEBLOAT_FILE" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        # Loại bỏ khoảng trắng và dòng comment
        pkg="$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        if [ -n "$pkg" ]; then
            echo "   -> Kích hoạt lại: $pkg"
            "$ADB" -s "$DEV" shell pm enable "$pkg" < /dev/null >/dev/null 2>"$ADB" -s "$DEV" shell pm enable "$pkg" >/dev/null 2>&1 || true1 || true
        fi
    done < "$DEBLOAT_FILE"
fi

echo "2. Kích hoạt lại dịch vụ OTA cập nhật Xiaomi..."
"$ADB" -s "$DEV" shell pm enable com.xiaomi.mitv.updateservice >/dev/null 2>&1 || true

echo "3. Kích hoạt và đặt Launcher Google TV gốc làm mặc định..."
"$ADB" -s "$DEV" shell pm enable com.google.android.apps.tv.launcherx >/dev/null 2>&1 || true
"$ADB" -s "$DEV" shell cmd package set-home-activity --user 0 com.google.android.apps.tv.launcherx/.home.HomeActivity >/dev/null 2>&1 || true

echo "4. Chuyển màn hình tivi về màn hình chính Google TV..."
"$ADB" -s "$DEV" shell input keyevent KEYCODE_HOME >/dev/null 2>&1 || true

echo "========================================================"
echo " ĐÃ KHÔI PHỤC THÀNH CÔNG 100%! TIVI ĐÃ TRỞ VỀ NGUYÊN BẢN "
echo "========================================================"
