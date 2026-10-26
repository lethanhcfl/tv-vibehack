# [Update: 26/10/2026 19:06]
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
- Tổng tiến trình hệ thống giảm từ 538 xuống còn **390 tasks**, giải phóng thêm lượng lớn RAM và CPU rảnh rỗi đạt gần 300%.

---

## 3. Hướng Dẫn Tùy Biến & Khôi Phục Cho Sếp
- Đổi app ở Dock: sửa `launcher/app/src/main/res/values/config.xml`.
- Đổi lời chào: sửa `launcher/app/src/main/res/values/strings.xml`.
- Chạy cập nhật 1 chạm:
  ```bash
  ./launcher/update-launcher.sh
  ```
- Khôi phục khẩn cấp 1 chạm (bật lại toàn bộ):
  ```bash
  ./examples/xiaomi-a75pro-river/restore.sh
  ```
