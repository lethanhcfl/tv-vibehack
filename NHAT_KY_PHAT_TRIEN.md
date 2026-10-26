# [Update: 26/10/2026 16:39]
# NHẬT KÝ PHÁT TRIỂN DỰ ÁN: TỐI ƯU HÓA & CÀI ĐẶT LAUNCHER APPLE TV CHO XIAOMI TV A75 PRO

## 1. Thông Tin Thiết Bị Mục Tiêu
- **Model:** Xiaomi TV A75 Pro (`MiTV-MZTU0`)
- **Tên mã phần cứng (Codename):** `river`
- **Màn hình:** 75 inch 4K 120Hz
- **Hệ điều hành:** Android 14 (API 34) - Xiaomi HyperOS TV (`UKN1.240806.017.V816.0.26.6.2.6.URTMIXM`)
- **Địa chỉ IP ADB Wireless:** `192.168.1.164:5555`

---

## 2. Nhật Ký Xử Lý Sự Cố Nghẽn CPU & Phục Hồi An Toàn (26/10/2026)

### Sự cố phát sinh:
- Sau khi cài Launcher Apple TV và tắt launcher gốc (`com.google.android.apps.tv.launcherx`), hệ thống xuất hiện tình trạng nhận tín hiệu điều khiển cực kỳ chậm, tivi tự khởi động lại và xuất hiện màn hình đen.
- **Nguyên nhân cốt lõi (Phát hiện qua ADB Logcat):**
  - Android 14 trên Xiaomi HyperOS TV có tiến trình giám sát hệ thống là `com.google.android.tungsten.setupwraith` (Setup Wraith).
  - Khi `launcherx` bị vô hiệu hóa (`disabled-user`), `setupwraith` lập tức kích hoạt cơ chế `RecoveryActivity` khẩn cấp để tự động tìm và khôi phục launcher gốc.
  - Do `launcherx` không tìm thấy, `setupwraith` rơi vào **vòng lặp vô tận (chạy lại 20 lần/giây)**, khiến `system_server` ngốn 92% CPU, đẩy chỉ số **Load Average lên mức 32.5** (quá tải nghiêm trọng trên chip 4 nhân).
  - Tải CPU quá cao làm nghẽn tiến trình Bluetooth Remote và kích hoạt cơ chế tự bảo vệ `RescueParty` của Android, gây màn hình đen tạm thời.

### Biện pháp can thiệp & Kết quả:
1. **Khôi phục ngay lập tức launcherx:**
   - Kích hoạt lại `com.google.android.apps.tv.launcherx` và đặt làm màn hình chính.
   - Vòng lặp cứu hộ của `setupwraith` chấm dứt hoàn toàn.
   - Chỉ số CPU lập tức hạ nhiệt: Tỷ lệ CPU rảnh rỗi (Idle) tăng vọt lên **297% / 400%**, RAM trống tăng lên hơn **244MB**.
2. **Kích hoạt lại Trình quản lý TV (Xiaomi TV Manager):**
   - Theo yêu cầu của Sếp, đã kích hoạt lại gói `com.xiaomi.mitv.tvmanager`.
   - Sếp có thể vào kiểm tra dung lượng RAM, bộ nhớ trống bất cứ lúc nào.
3. **Màn hình tivi:**
   - Đã hiển thị trở lại bình thường 100%, remote phản hồi tức thì, không còn giật lag.

---

## 3. Tình Trạng Tối Ưu Hiện Tại Của Tivi
- **16 gói rác / telemetry / quảng cáo PatchWall / cập nhật OTA:** Đang được vô hiệu hóa an toàn, không còn quảng cáo hay tiến trình theo dõi ngầm.
- **Các tính năng giữ nguyên 100%:**
  - `com.google.android.katniss` (Tìm kiếm giọng nói Remote Google Assistant).
  - `com.google.android.apps.mediashell` (Chromecast built-in).
  - `com.xiaomi.mitv.smartshare` (Mi Cast chia sẻ không dây).
  - `com.xiaomi.mitv.tvmanager` (Trình quản lý TV xem RAM / bộ nhớ trống).
  - `com.google.android.apps.tv.launcherx` (Launcher gốc Google TV hoạt động ổn định, tránh kích hoạt lỗi Watchdog).

---

## 4. Hướng Dẫn Sếp Khôi Phục Khẩn Cấp (1-Click)
Nếu cần khôi phục lại toàn bộ:
```bash
./examples/xiaomi-a75pro-river/restore.sh
```
