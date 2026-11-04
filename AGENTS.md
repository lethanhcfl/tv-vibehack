<!-- [Update: 04/11/2026 11:35]
Tích hợp cấu hình Agent Memory (agentmemory) đồng bộ toàn hệ sinh thái -->

# Hướng dẫn Agent (Agent Guidelines)

<!-- agentmemory:start -->
## Agent memory (agentmemory) & Cơ chế Tự Động Thiết Lập (Auto Bootstrap)

You have persistent long-term memory via the agentmemory MCP server. Tools: `memory_recall`, `memory_smart_search`, `memory_save`, `memory_sessions`.

> [!IMPORTANT]
> **CƠ CHẾ TỰ ĐỘNG THIẾT LẬP KHI CHUYỂN SANG MÁY TÍNH KHÁC (Windows / Mac / Linux):**
> Nếu khi bắt đầu phiên làm việc trên máy tính mới hoặc môi trường mới, AI nhận thấy **chưa có công cụ MCP `memory_recall`** trong danh sách tools:
> 👉 **AI BẮT BUỘC TỰ ĐỘNG THỰC THI NGAY:**
> ```bash
> python .agents/setup_agentmemory.py
> ```
> *(Hoặc trên Windows PowerShell: `powershell -ExecutionPolicy Bypass -File .agents/setup_agentmemory.ps1`)*
> Script này sẽ tự động:
> 1. Kiểm tra môi trường Node.js / npm và tự động cài đặt `@agentmemory/mcp` nếu máy chưa có.
> 2. Đăng ký tự động MCP Server `agentmemory` vào file cấu hình toàn cục `mcp_config.json` của Antigravity trên máy đó.
> 3. Tự động sao chép toàn bộ 17 skills vào `~/.gemini/config/skills/` và đồng bộ quy tắc bộ nhớ vào `GEMINI.md` toàn cục.
> 4. Sau khi script chạy xong, AI tự động nạp lại công cụ và gọi `memory_recall` bình thường mà không cần người dùng thao tác bất kỳ lệnh nào.

- At the START of a task, call `memory_recall` (or `memory_smart_search`) with the task context to load relevant past decisions, fixes, and preferences before asking the user to repeat anything.
- When you learn something durable (a decision, a fix, a gotcha, a user preference, a project convention), call `memory_save` to persist it.
- Prefer recalling over re-deriving, and save concise reusable facts rather than transcripts.
<!-- agentmemory:end -->
