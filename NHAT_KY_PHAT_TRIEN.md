# [Update: 26/10/2026 16:23]
# NHẬT KÝ PHÁT TRIỂN DỰ ÁN: TỐI ƯU HÓA & CÀI ĐẶT LAUNCHER APPLE TV CHO XIAOMI TV A75 PRO

## 1. Thông Tin Thiết Bị Mục Tiêu
- **Model:** Xiaomi TV A75 Pro (`MiTV-MZTU0`)
- **Tên mã phần cứng (Codename):** `river`
- **Màn hình:** 75 inch 4K 120Hz
- **Hệ điều hành:** Android 14 (API 34) - Xiaomi HyperOS TV (`UKN1.240806.017.V816.0.26.6.2.6.URTMIXM`)
- **Địa chỉ IP ADB Wireless:** `192.168.1.164:5555`

---

## 2. Các Bước Đã Thực Hiện & Kết Quả Đạt Được

### Bước 1: Sao lưu toàn diện hệ thống (Pre-change Backup)
- Lưu trữ toàn bộ tại: `backups/xiaomi-a75pro-river/`
- Danh sách 174 gói APK hệ thống (`packages_full.txt`)
- Trạng thái 172 gói đang bật (`packages_enabled.txt`)
- Toàn bộ thiết lập hệ thống: `getprop_all.txt`, `settings_global.txt`, `settings_secure.txt`, `settings_system.txt`
- Màn hình gốc trước can thiệp: `current_screen.png`

### Bước 2: Tối ưu hóa an toàn (Debloat) - Mục 2
- Sử dụng phương thức an toàn tuyệt đối: `pm disable-user --user 0 <package>` (không xóa file APK gốc, không ảnh hưởng phân vùng hệ thống, khôi phục được 100%).
- **Đã vô hiệu hóa thành công 16 gói rác & telemetry:**
  1. `com.miui.tv.analytics` (Thu thập dữ liệu phân tích MIUI)
  2. `com.xiaomi.statistic` (Thống kê hành vi người dùng)
  3. `com.google.android.feedback` (Gửi báo cáo lỗi nền)
  4. `com.android.tv.feedbackconsent` (Đồng thuận báo cáo phản hồi)
  5. `com.mitv.tvhome.atv` (PatchWall ATV)
  6. `com.mitv.tvhome.michannel` (Kênh quảng cáo đối tác Xiaomi)
  7. `com.mitv.tvhome.mitvplus` (Mi TV Plus OTT)
  8. `com.mitv.tvhome.oemtab` (Tab quảng cáo OEM)
  9. `com.xm.webcontent` (Tải nội dung web tài trợ)
  10. `com.xiaomi.android.tvsetup.partnercustomizer` (Tùy biến đối tác)
  11. `com.xiaomi.mitv.tvmanager` (Trình dọn dẹp ảo gây giật lag)
  12. `com.xiaomi.mitv.scenemode` (Chế độ ngữ cảnh chạy ngầm)
  13. `com.xiaomi.mimusic2` (Mi Music nội địa)
  14. `com.mitv.gallery` (Bộ sưu tập ảnh mặc định)
  15. `com.google.android.play.games` (Google Play Games TV)
  16. `com.xiaomi.mitv.updateservice` (Dịch vụ cập nhật OTA Xiaomi - đã tắt để tránh tự động cập nhật đè cấu hình)
- **Đặc biệt giữ nguyên vẹn 100%:**
  - `com.google.android.katniss`: Tìm kiếm giọng nói tiếng Việt Google Assistant trên Remote.
  - `com.google.android.apps.mediashell`: Tính năng truyền phát màn hình Chromecast built-in.
  - `com.xiaomi.mitv.smartshare`: Mi Cast chia sẻ không dây.

### Bước 3: Cài đặt Launcher chuẩn phong cách Apple TV - Mục 3
- Tích hợp môi trường độc lập: Portable OpenJDK 17 (`tools/jdk17`) và Android SDK 34 (`tools/android-sdk`).
- Cấu hình file `launcher/app/src/main/res/values/config.xml` với đúng 4 ứng dụng yêu thích tại thanh Dock theo chỉ đạo của Sếp:
  1. **YouTube:** `com.google.android.youtube.tv`
  2. **FPT Play:** `net.fptplay.ottbox`
  3. **Phim 4K:** `com.oxootv.spagreen`
  4. **Stremio:** `com.stremio.one`
- Đã biên dịch APK ra `launcher/app/build/outputs/apk/debug/app-debug.apk` và cài đặt lên tivi.
- Thiết lập Launcher Apple TV làm mặc định (`cmd package set-home-activity --user 0 com.gathin.tvhome/.MainActivity`).
- Tạm thời vô hiệu hóa Google TV Launcher gốc (`com.google.android.apps.tv.launcherx`) để phím Home trên điều khiển tivi chuyển hướng ngay lập tức về giao diện Apple TV tinh gọn, mượt mà và không còn bất kỳ quảng cáo nào.
- Ảnh chụp kiểm tra thực tế: `backups/xiaomi-a75pro-river/active_apple_tv_screen.png`.

---

## 3. Hướng Dẫn Tùy Chỉnh Sau Này & Khôi Phục (Dành Cho Sếp)

### A. Cách thay đổi 4 ứng dụng yêu thích ở Dock
Khi Sếp muốn đổi các ứng dụng khác:
1. Mở file cấu hình: `launcher/app/src/main/res/values/config.xml`
2. Đổi các dòng `<item>tên_gói_ứng_dụng</item>` trong thẻ `<string-array name="dock_apps">`.
3. Chạy script cập nhật 1 chạm:
   ```bash
   ./launcher/update-launcher.sh
   ```
   Tivi sẽ tự động nạp launcher mới sau 5 giây.

### B. Cách khôi phục (Restore) 100% về nguyên bản gốc của Xiaomi
Nếu bất kỳ lúc nào Sếp muốn quay về giao diện gốc:
Chỉ cần chạy lệnh sau trên Terminal của MacBook:
```bash
./examples/xiaomi-a75pro-river/restore.sh
```
Script sẽ tự động:
- Bật lại toàn bộ 16 ứng dụng đã tắt.
- Bật lại tính năng cập nhật OTA Xiaomi.
- Đặt lại Google TV Launcher gốc làm mặc định.
- Tivi trở lại 100% như lúc mới mua ban đầu.
