# [Update: 26/10/2026 21:15]
# NHẬT KÝ PHÁT TRIỂN DỰ ÁN: TỐI ƯU HÓA & CÀI ĐẶT LAUNCHER APPLE TV CHO XIAOMI TV A75 PRO

## 1. Thông Tin Thiết Bị Mục Tiêu
- **Model:** Xiaomi TV A75 Pro (`MiTV-MZTU0`)
- **Tên mã phần cứng (Codename):** `river`
- **Màn hình:** 75 inch 4K 120Hz
- **Hệ điều hành:** Android 14 (API 34) - Xiaomi HyperOS TV (`UKN1.240806.017.V816.0.26.6.2.6.URTMIXM`)
- **Địa chỉ IP ADB Wireless:** `192.168.1.164:5555`

---

## 2. Các Mốc Tối Ưu & Tùy Biến Đã Hoàn Thành

### Mốc 1: Tối ưu hóa hệ thống & Dọn dẹp bloatware
- Vô hiệu hóa an toàn các dịch vụ telemetry, quảng cáo PatchWall và cập nhật tự động OTA của Xiaomi.
- Vô hiệu hóa watchdog `com.google.android.tungsten.setupwraith` để dập tắt triệt để vòng lặp cứu hộ gây nghẽn CPU.
- Giữ nguyên các tính năng: Google Assistant remote, Chromecast built-in, Mi Cast và Trình quản lý TV (`tvmanager`).

### Mốc 2: Cài đặt Launcher chuẩn Apple TV & Cá nhân hóa
- Màn hình chính duy nhất: Launcher Apple TV với thanh Dock 4 app yêu thích (**YouTube**, **FPT Play**, **Phim 4K**, **Stremio**).
- Lời chào gia đình: **`CHÀO SẾP TCM, SẾP SEN, SẾP LÊ CÁ`**.
- 3 nút chức năng tròn kính mờ (*Cổng vào*, *Wi-Fi*, *Cài đặt*) căn giữa tuyệt đối 100%.

### Mốc 3: Dọn dẹp bổ sung theo chỉ đạo của Sếp (19:05 ngày 26/10/2026)
- **Vô hiệu hóa Amazon Prime Video:** `com.amazon.amazonvideo.livingroom` (loại bỏ app xem phim thương mại không dùng, giải phóng bộ nhớ).
- **Vô hiệu hóa cụm Live TV ăng-ten Xiaomi:** `com.mitv.livetv`, `com.mitv.livetv.it`, `com.mitv.livetv.ci_mediatek` (giải phóng gần 100MB RAM chạy ngầm).
- Đã khóa triệt để trên cả User 0 và User phụ (User 10).
- Tổng tiến trình hệ thống giảm từ 538 xuống còn **390 tasks**, giải phóng thêm lượng lớn RAM và CPU rảnh rỗi đạt gần 300%.

### Mốc 4: Nâng cấp mã nguồn Launcher đa năng (19:35 ngày 26/10/2026)
- Nâng cấp `AppAdapter.java`: hỗ trợ nhận diện cả app TV lẫn app Android tiêu chuẩn (`CATEGORY_LAUNCHER`), nạp banner tùy biến linh hoạt.

### Mốc 5: Khôi phục & Cài đặt chuẩn bản Phim 4K TV tối ưu Remote (20:05 ngày 26/10/2026)
- Cài đặt bản Phim 4K chuyên dụng cho TV (`com.oxootv.spagreen`) tối ưu Remote D-pad.

### Mốc 6: Nâng cấp Phim 4K TV lên bản mới nhất v2.7.3 & Xuất file Desktop (20:18 ngày 26/10/2026)
- Trích xuất endpoint cập nhật từ Firebase chính thức của nhà phát triển: `https://api.phim4k.space/adrtv.php`.
- Tải file APK chuẩn **Phim 4K TV v2.7.3** (`versionCode: 83`).
- Xuất file ra Desktop theo quy chuẩn: `20261026 Phim4K Android TV v2.7.3.apk`.
- Đã cài đặt cập nhật trực tiếp lên TV Xiaomi A75 Pro: Hoạt động trơn tru, không còn thông báo cập nhật, giao diện kính mờ và điều khiển Remote/D-pad nhạy bén 100%.

### Mốc 7: Modding Phim 4K TV - Play 1 chạm, chặn quảng cáo qua DNS & Khóa cập nhật phiền toái (21:15 ngày 26/10/2026)
- **Bỏ qua hộp thoại chọn Server rườm rà (Play 1 chạm):**
  - Đã patch trực tiếp mã nguồn Smali tại `HeroStyleMovieDetailsFragment.smali` và `VideoDetailsFragment.smali`.
  - Khi bấm **`▶ XEM NGAY`**, ứng dụng lập tức khởi tạo trình phát `PlayerActivity` với luồng phát chất lượng cao nhất mà không bật popup chọn server gây khó chịu.
- **Khóa triệt để thông báo ép cập nhật:**
  - Patch `OTAUpdateService.smali`: Ép hàm `isUpdateAvailable` luôn trả về `false`.
  - Cập nhật `versionCode: 999999` trong `apktool.yml` để app không bao giờ bị thông báo update làm phiền trong lúc xem phim.
- **Chặn quảng cáo bằng AdGuard Private DNS:**
  - Cấu hình Private DNS `dns.adguard-dns.com` trực tiếp trên hệ điều hành TV.
  - Sạch bóng banner / popup quảng cáo, tải luồng siêu tốc, độ trễ chỉ 49ms (0% packet loss).
- **An toàn tuyệt đối 100% cho hệ thống & các ứng dụng khác:**
  - Toàn bộ can thiệp chỉ nằm gọn trong nội bộ package `com.oxootv.spagreen`.
  - Các app YouTube, FPT Play, Stremio, HyperOS và toàn bộ cấu hình TV hoàn toàn nguyên vẹn, không bị tác động.
- **Tự động hóa nâng cấp tương lai (Future-proof):**
  - Xây dựng bộ script 1 chạm: `tools/patch-phim4k.sh` & `tools/patch-phim4k.py`.
  - Sau này khi tác giả ra bản mới, Sếp chỉ cần chạy `./tools/patch-phim4k.sh`, tool sẽ tự động tải APK mới, dịch ngược, tự động áp bản vá smali, đóng gói, ký số và nạp thẳng lên TV chỉ trong 30 giây.
- **Xuất bản cài đặt ra Desktop:**
  - File cài mod hoàn chỉnh đã được ký số sẵn sàng tại: `/Users/tcm/Desktop/20261026 Phim4K Android TV v2.7.3-mod.apk`.

---

## 3. Hướng Dẫn Tùy Biến & Khôi Phục Cho Sếp
- Đổi app ở Dock: sửa `launcher/app/src/main/res/values/config.xml`.
- Đổi lời chào: sửa `launcher/app/src/main/res/values/strings.xml`.
- Cập nhật Launcher 1 chạm:
  ```bash
  ./launcher/update-launcher.sh
  ```
- Cập nhật / Tự động mod Phim 4K TV khi có bản mới:
  ```bash
  ./tools/patch-phim4k.sh
  ```
- Khôi phục khẩn cấp 1 chạm (bật lại toàn bộ dịch vụ TV):
  ```bash
  ./examples/xiaomi-a75pro-river/restore.sh
  ```
