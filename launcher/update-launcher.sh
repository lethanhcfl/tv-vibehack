#!/usr/bin/env bash
# [Update: 26/10/2026 16:21]
# Script tự động biên dịch và cập nhật Launcher Apple TV lên Xiaomi TV A75 Pro
# Dùng bộ công cụ SDK/JDK độc lập đã tích hợp sẵn trong repo

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

export JAVA_HOME="$PROJECT_ROOT/tools/jdk17/Contents/Home"
export ANDROID_HOME="$PROJECT_ROOT/tools/android-sdk"
export PATH="$JAVA_HOME/bin:$PATH"

ADB="$PROJECT_ROOT/tools/platform-tools/adb"
if [ ! -x "$ADB" ]; then
    ADB="adb"
fi

DEV="${TV_HOST:-192.168.1.164:5555}"

echo "========================================================"
echo " [LAUNCHER] BIÊN DỊCH VÀ CẬP NHẬT LAUNCHER APPLE TV "
echo "========================================================"
echo "1. Đang biên dịch APK từ mã nguồn launcher..."
cd "$SCRIPT_DIR"
./gradlew assembleDebug -q --console=plain

APK="$SCRIPT_DIR/app/build/outputs/apk/debug/app-debug.apk"
if [ ! -f "$APK" ]; then
    echo "Lỗi: Không tìm thấy file APK sau khi build!"
    exit 1
fi

echo "2. Đang kết nối tới TV ($DEV)..."
"$ADB" connect "$DEV" || true

echo "3. Cài đặt APK mới lên TV..."
"$ADB" -s "$DEV" install -r "$APK"

echo "4. Cấp quyền truy cập vị trí và kích hoạt màn hình chính..."
"$ADB" -s "$DEV" shell pm grant com.gathin.tvhome android.permission.ACCESS_FINE_LOCATION 2>/dev/null || true
"$ADB" -s "$DEV" shell cmd package set-home-activity --user 0 com.gathin.tvhome/.MainActivity

echo "5. Chuyển TV về giao diện Apple TV mới..."
"$ADB" -s "$DEV" shell input keyevent KEYCODE_HOME

echo "========================================================"
echo " CẬP NHẬT THÀNH CÔNG 100%! HÃY NHÌN LÊN MÀN HÌNH TIVI "
echo "========================================================"
