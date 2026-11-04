# Sổ Tay Kiểm Soát Phiên Bản & Mốc Thời Gian (Time-Machine Checkpoints)

> [!TIP]
> **Cơ chế hoạt động:** Mỗi khi Sếp phản hồi từ khóa `"ngon"`, `"ổn rồi"`, `"chốt"`, AI sẽ tự động đóng dấu một Git Tag Checkpoint và ghi lại đầy đủ mốc thời gian, ngữ cảnh công việc và danh sách file ổn định vào bảng bên dưới.
> 
> **Cách khôi phục 1 file khi phát hiện lỗi cũ (Không làm mất code mới):**
> ```bash
> git checkout <MÃ_CHECKPOINT> -- path/to/file_can_phuc_hoi.ext
> ```

## Nhật Ký Các Mốc Ổn Định Đã Chốt

| STT | Mã Checkpoint Tag | Thời Điểm | Ngữ Cảnh Công Việc & Tính Năng Chạy Ngon | Danh Sách File Ổn Định | Lệnh Phục Hồi Chọn Lọc 1-Click |
| :---: | :--- | :---: | :--- | :--- | :--- |
| **0** | `checkpoint/20261104_1215_init` | 2026-11-04 12:15 | Khởi tạo hệ thống Time-Machine Checkpoint & Anti-Regression | Toàn bộ dự án | `git checkout checkpoint/20261104_1215_init -- <file>` |
