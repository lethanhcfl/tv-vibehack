#!/usr/bin/env bash
# [Update: 26/10/2026 21:10]
# Script tu dong 1-cham: Tai ban goc, patch 1-touch play, bo update, dong goi va cai len TV

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

JAVA="$SCRIPT_DIR/jdk17/Contents/Home/bin/java"
if [ ! -f "$JAVA" ]; then
    JAVA="java"
fi

APKTOOL="$SCRIPT_DIR/apktool.jar"
ZIPALIGN="$SCRIPT_DIR/android-sdk/build-tools/34.0.0/zipalign"
APKSIGNER="$SCRIPT_DIR/android-sdk/build-tools/34.0.0/lib/apksigner.jar"
ADB="$SCRIPT_DIR/platform-tools/adb"
TV_IP="${TV_HOST:-192.168.1.164}:5555"
KEYSTORE="${HOME}/.android/debug.keystore"

echo "=========================================================="
echo "    BỘ CÔNG CỤ TỰ ĐỘNG CẬP NHẬT & MOD PHIM 4K TV"
echo "=========================================================="

INPUT_APK="${1:-}"
TEMP_SRC="$SCRIPT_DIR/phim4k_temp_src"
BUILD_UNSIGNED="$SCRIPT_DIR/phim4k_temp_unsigned.apk"
BUILD_ALIGNED="$SCRIPT_DIR/phim4k_temp_aligned.apk"
BUILD_SIGNED="$SCRIPT_DIR/phim4k_tv_mod.apk"

# 1. Tải APK mới nhất nếu không truyền file
if [ -z "$INPUT_APK" ]; then
    echo "[1/6] Đang kiểm tra phiên bản mới nhất từ máy chủ Phim 4K..."
    LATEST_JSON=$(curl -s "https://api.phim4k.space/adrtv.php")
    LATEST_URL=$(echo "$LATEST_JSON" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('apk_url',''))")
    LATEST_VER=$(echo "$LATEST_JSON" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data.get('version_name','latest'))")
    
    if [ -z "$LATEST_URL" ]; then
        echo "[!] Không thể lấy link tải tự động. Vui lòng truyền đường dẫn file APK: $0 <path_to_apk>"
        exit 1
    fi
    
    INPUT_APK="$SCRIPT_DIR/phim4k_${LATEST_VER}_raw.apk"
    echo "    -> Phát hiện bản $LATEST_VER. Đang tải về: $LATEST_URL"
    curl -L -o "$INPUT_APK" "$LATEST_URL"
else
    echo "[1/6] Sử dụng file APK được chỉ định: $INPUT_APK"
fi

# 2. Decompile APK
echo "[2/6] Đang giải nén mã nguồn bằng Apktool..."
rm -rf "$TEMP_SRC"
"$JAVA" -jar "$APKTOOL" d -f "$INPUT_APK" -o "$TEMP_SRC" > /dev/null

# 3. Patch smali
echo "[3/6] Đang thực hiện vá lỗi (Play 1 chạm + Khóa popup update)..."
python3 "$SCRIPT_DIR/patch-phim4k.py" "$TEMP_SRC"

# 4. Build APK
echo "[4/6] Đang đóng gói APK mới..."
rm -f "$BUILD_UNSIGNED" "$BUILD_ALIGNED"
"$JAVA" -jar "$APKTOOL" b "$TEMP_SRC" -o "$BUILD_UNSIGNED" > /dev/null

# 5. Zipalign & Ký số (Sign)
echo "[5/6] Đang tối ưu (Zipalign) và Ký số (Apksigner)..."
"$ZIPALIGN" -v -p 4 "$BUILD_UNSIGNED" "$BUILD_ALIGNED" > /dev/null

if [ ! -f "$KEYSTORE" ]; then
    echo "    -> Chưa có keystore debug, đang khởi tạo tự động..."
    mkdir -p "$(dirname "$KEYSTORE")"
    keytool -genkey -v -keystore "$KEYSTORE" -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Android Debug,O=Android,C=US"
fi

"$JAVA" -jar "$APKSIGNER" sign --ks "$KEYSTORE" --ks-pass pass:android --key-pass pass:android --out "$BUILD_SIGNED" "$BUILD_ALIGNED"

TODAY=$(date +%Y%m%d)
DESKTOP_OUT="$HOME/Desktop/${TODAY} Phim4K Android TV Mod.apk"
cp "$BUILD_SIGNED" "$DESKTOP_OUT"
echo "    -> Đã xuất bản cài mod ra Desktop: $DESKTOP_OUT"

# 6. Cài đặt trực tiếp lên TV
echo "[6/6] Kiểm tra kết nối tới TV ($TV_IP)..."
if "$ADB" -s "$TV_IP" get-state > /dev/null 2>&1; then
    echo "    -> TV đang online! Tiến hành cài đặt / cập nhật ứng dụng..."
    if ! "$ADB" -s "$TV_IP" install -r "$BUILD_SIGNED" > /dev/null 2>&1; then
        echo "    -> Phát hiện sai lệch chữ ký bản cũ, gỡ bản cũ và cài đặt lại an toàn..."
        "$ADB" -s "$TV_IP" uninstall com.oxootv.spagreen > /dev/null 2>&1 || true
        "$ADB" -s "$TV_IP" install "$BUILD_SIGNED"
    fi
    echo "[✓] Đã cài đặt hoàn tất lên TV Xiaomi A75 Pro!"
else
    echo "[*] TV hiện chưa kết nối ADB. Sếp có thể dùng file APK ngoài Desktop để cài đặt khi cần."
fi

# Dọn dẹp tạm
rm -rf "$TEMP_SRC" "$BUILD_UNSIGNED" "$BUILD_ALIGNED"
echo "=========================================================="
echo "    HOÀN TẤT THÀNH CÔNG 100%!"
echo "=========================================================="
