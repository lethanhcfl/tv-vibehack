# [Update: 26/10/2026 16:56]
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
- Vô hiệu hóa an toàn 15 dịch vụ telemetry, quảng cáo PatchWall và cập nhật tự động OTA của Xiaomi.
- Vô hiệu hóa watchdog `com.google.android.tungsten.setupwraith` để dập tắt triệt để vòng lặp cứu hộ gây nghẽn CPU.
- Giữ nguyên các tính năng: Google Assistant remote, Chromecast built-in, Mi Cast và Trình quản lý TV (`tvmanager`).

### Mốc 2: Cài đặt Launcher chuẩn Apple TV
- Đã đưa launcher Apple TV làm màn hình chính duy nhất.
- 4 ứng dụng yêu thích ghim tại thanh Dock: **YouTube**, **FPT Play**, **Phim 4K**, **Stremio**.

### Mốc 3: Cá nhân hóa giao diện độc quyền cho gia đình Sếp
- **Lời chào gia đình:** Góc trên bên trái hiển thị đầy đủ: **`CHÀO SẾP TCM, SẾP SEN, SẾP LÊ CÁ`**.
- **3 nút chức năng tối giản:** Chuyển sang dạng nút tròn kính mờ (kích thước 44dp x 44dp) chuẩn phong cách Apple TV Control Center (*Cổng vào*, *Wi-Fi*, *Cài đặt*).

---

## 3. Hướng Dẫn Tùy Biến & Khôi Phục Cho Sếp
- Đổi app ở Dock: sửa `launcher/app/src/main/res/values/config.xml`.
- Đổi lời chào: sửa `launcher/app/src/main/res/values/strings.xml`.
- Chạy cập nhật 1 chạm:
  ```bash
  ./launcher/update-launcher.sh
  ```
- Khôi phục khẩn cấp 1 chạm:
  ```bash
  ./examples/xiaomi-a75pro-river/restore.sh
  ```
