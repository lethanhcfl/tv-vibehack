# [Update: 26/10/2026 16:44]
# NHẬT KÝ PHÁT TRIỂN DỰ ÁN: TỐI ƯU HÓA & CÀI ĐẶT LAUNCHER APPLE TV CHO XIAOMI TV A75 PRO

## 1. Thông Tin Thiết Bị Mục Tiêu
- **Model:** Xiaomi TV A75 Pro (`MiTV-MZTU0`)
- **Tên mã phần cứng (Codename):** `river`
- **Màn hình:** 75 inch 4K 120Hz
- **Hệ điều hành:** Android 14 (API 34) - Xiaomi HyperOS TV (`UKN1.240806.017.V816.0.26.6.2.6.URTMIXM`)
- **Địa chỉ IP ADB Wireless:** `192.168.1.164:5555`

---

## 2. Giải Pháp Toàn Diện Cho Giao Diện Apple TV & Triệt Tiêu Lỗi Xung Đột

### Vấn đề đã xử lý:
1. Khi tắt `launcherx`, tiến trình giám sát `com.google.android.tungsten.setupwraith` liên tục kích hoạt `RecoveryActivity` tìm kiếm launcher gốc, gây quá tải CPU 100% (Load average 32.5) dẫn tới đơ remote và màn hình đen.
2. Khi bật lại `launcherx`, tivi lại ưu tiên hiển thị Google TV thay vì Launcher Apple TV.

### Giải pháp triệt để:
1. **Vô hiệu hóa đồng thời watchdog `setupwraith`:**
   - Chạy `pm disable-user --user 0 com.google.android.tungsten.setupwraith`.
   - Chạy `pm disable-user --user 0 com.google.android.apps.tv.launcherx`.
   - Kết quả: Triệt tiêu 100% vòng lặp cứu hộ, CPU lập tức hạ về mức rảnh rỗi **349% / 400%**, hoàn toàn êm ái và không có bất kỳ xung đột nền nào.
2. **Kích hoạt Launcher Apple TV làm mặc định duy nhất:**
   - `com.gathin.tvhome/.MainActivity` trở thành Home Launcher duy nhất của hệ thống.
   - Nhấn phím Home trên điều khiển chuyển hướng tức thì về Apple TV Launcher với 4 app yêu thích ghim ở Dock: **YouTube**, **FPT Play**, **Phim 4K**, **Stremio**.
3. **Mở lại Trình quản lý TV (Xiaomi TV Manager):**
   - Đã bật lại `com.xiaomi.mitv.tvmanager` theo yêu cầu của Sếp để theo dõi RAM và bộ nhớ trống.

---

## 3. Tình Trạng Thiết Bị Hiện Tại
- [x] Giao diện chuẩn Apple TV cực kỳ sạch, không quảng cáo, mở là lên ngay.
- [x] Remote phản hồi cực nhanh, không còn giật lag.
- [x] Giữ nguyên 100% Google Assistant, Chromecast built-in, Mi Cast và Trình quản lý TV.
- [x] Khóa cập nhật OTA Xiaomi để tránh bị can thiệp ngoài ý muốn.
- [x] Script phục hồi khẩn cấp 1 chạm: `examples/xiaomi-a75pro-river/restore.sh`.
