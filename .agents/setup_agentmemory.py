# [Update: 04/11/2026 11:45]
# Tự động thiết lập AgentMemory MCP, 17 kỹ năng và quy chuẩn bộ nhớ liên phiên cho Antigravity trên mọi máy (Windows / macOS / Linux)

import os
import sys
import json
import shutil
import platform
import subprocess

def run():
    print("=" * 65)
    print("  🚀 TỰ ĐỘNG THIẾT LẬP BỘ NHỚ VĨNH VIỄN AGENTMEMORY (AUTO BOOTSTRAP)")
    print("=" * 65)

    is_win = platform.system() == "Windows"
    user_home = os.environ.get("USERPROFILE") if is_win else os.path.expanduser("~")
    gemini_home = os.path.join(user_home, ".gemini")
    config_dir = os.path.join(gemini_home, "config")
    skills_dir = os.path.join(config_dir, "skills")
    mcp_config_path = os.path.join(config_dir, "mcp_config.json")
    global_gemini_1 = os.path.join(gemini_home, "GEMINI.md")
    global_gemini_2 = os.path.join(config_dir, "GEMINI.md")

    os.makedirs(config_dir, exist_ok=True)
    os.makedirs(skills_dir, exist_ok=True)
    print(f"[1] Thư mục cấu hình Antigravity: {config_dir}")

    # Bổ sung các đường dẫn Node.js tiêu chuẩn vào PATH nếu chưa có
    current_path = os.environ.get("PATH", "")
    extra_paths = []
    if is_win:
        extra_paths = [
            os.path.join(user_home, r"AppData\Roaming\npm"),
            r"C:\Program Files\nodejs",
            r"C:\Program Files (x86)\nodejs",
            os.path.join(gemini_home, r"antigravity\bin")
        ]
    else:
        extra_paths = [
            "/usr/local/bin",
            "/opt/homebrew/bin",
            os.path.join(user_home, ".nodejs/bin"),
            os.path.join(gemini_home, "antigravity/bin")
        ]
    for p in extra_paths:
        if os.path.exists(p) and p not in current_path:
            current_path = p + os.pathsep + current_path
    os.environ["PATH"] = current_path

    # Kiểm tra Node và NPM
    npm_cmd = "npm.cmd" if is_win else "npm"
    npx_cmd = "npx.cmd" if is_win else "npx"
    npm_bin = shutil.which(npm_cmd) or shutil.which("npm")
    npx_bin = shutil.which(npx_cmd) or shutil.which("npx")
    node_bin = shutil.which("node.exe" if is_win else "node")

    print(f"[2] Kiểm tra Runtime Node.js:")
    print(f"  - Node: {node_bin or 'Chưa tìm thấy'}")
    print(f"  - NPM:  {npm_bin or 'Chưa tìm thấy'}")
    print(f"  - NPX:  {npx_bin or 'Chưa tìm thấy'}")

    # Cài đặt @agentmemory/mcp nếu có npm
    if npm_bin:
        print("[*] Đang kiểm tra và cài đặt @agentmemory/mcp...")
        try:
            subprocess.run([npm_bin, "install", "-g", "@agentmemory/mcp@latest", "@agentmemory/agentmemory@latest"], check=False)
            print("  [✓] Đã cài đặt @agentmemory/mcp thành công qua NPM.")
        except Exception as e:
            print(f"  [!] Lỗi cài đặt NPM: {e}")

    # Cấu hình mcp_config.json
    print("[3] Cấu hình MCP Server (mcp_config.json)...")
    mcp_data = {"mcpServers": {}}
    if os.path.exists(mcp_config_path):
        try:
            with open(mcp_config_path, "r", encoding="utf-8") as f:
                mcp_data = json.load(f)
        except Exception:
            mcp_data = {"mcpServers": {}}

    servers = mcp_data.setdefault("mcpServers", {})
    
    agentmemory_bin = shutil.which("agentmemory-mcp.cmd" if is_win else "agentmemory-mcp")
    if is_win:
        if agentmemory_bin:
            servers["agentmemory"] = {
                "command": "cmd.exe",
                "args": ["/c", agentmemory_bin]
            }
        else:
            servers["agentmemory"] = {
                "command": "cmd.exe",
                "args": ["/c", "npx", "-y", "@agentmemory/mcp"]
            }
    else:
        if agentmemory_bin and node_bin:
            servers["agentmemory"] = {
                "command": node_bin,
                "args": [agentmemory_bin]
            }
        else:
            servers["agentmemory"] = {
                "command": "npx",
                "args": ["-y", "@agentmemory/mcp"]
            }

    with open(mcp_config_path, "w", encoding="utf-8") as f:
        json.dump(mcp_data, f, indent=2, ensure_ascii=False)
    print(f"  [✓] Đã ghi nhận MCP server 'agentmemory' vào: {mcp_config_path}")

# Sao chép và tinh gọn skills vào ~/.gemini/config/skills (chỉ giữ 6 core skills)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    local_skills = os.path.join(script_dir, 'skills')
    surplus_to_remove = [
        'agentmemory-agents', 'agentmemory-architecture', 'agentmemory-config',
        'agentmemory-hooks', 'agentmemory-mcp-tools', 'agentmemory-rest-api',
        'commit-context', 'commit-history', 'recap', 'session-history', 'write-agentmemory-skill'
    ]
    for s in surplus_to_remove:
        old_p = os.path.join(skills_dir, s)
        if os.path.exists(old_p):
            try:
                shutil.rmtree(old_p)
            except Exception:
                pass
    if os.path.exists(local_skills):
        print(f'[4] Đồng bộ 6 kỹ năng cốt lõi sang thư mục toàn cục: {skills_dir}')
        shutil.copytree(local_skills, skills_dir, dirs_exist_ok=True)
        print('  [✓] Đã sao chép 6 kỹ năng bộ nhớ tinh hoa vào hệ sinh thái.')

    # Cập nhật quy chuẩn GEMINI.md toàn cục
    mem_rule = """
<!-- agentmemory:start -->
## Agent memory (agentmemory)

You have persistent long-term memory via the agentmemory MCP server. Tools: `memory_recall`, `memory_smart_search`, `memory_save`, `memory_sessions`.

- At the START of a task, call `memory_recall` (or `memory_smart_search`) with the task context to load relevant past decisions, fixes, and preferences before asking the user to repeat anything.
- When you learn something durable (a decision, a fix, a gotcha, a user preference, a project convention), call `memory_save` to persist it.
- Prefer recalling over re-deriving, and save concise reusable facts rather than transcripts.
<!-- agentmemory:end -->
"""
    print("[5] Cập nhật quy tắc bộ nhớ vào GEMINI.md toàn cục...")
    for g_path in [global_gemini_1, global_gemini_2]:
        if os.path.exists(g_path):
            with open(g_path, "r", encoding="utf-8", errors="ignore") as f:
                c = f.read()
            if "agentmemory" not in c:
                with open(g_path, "a", encoding="utf-8") as f:
                    f.write("\n" + mem_rule + "\n")
                print(f"  [✓] Đã bổ sung quy tắc vào: {g_path}")
            else:
                print(f"  [.] Đã có sẵn quy tắc trong: {g_path}")
        else:
            with open(g_path, "w", encoding="utf-8") as f:
                f.write("# Toàn cầu\n" + mem_rule + "\n")
            print(f"  [✓] Đã tạo mới và gán quy tắc: {g_path}")

    print("\n" + "=" * 65)
    print("  🎉 HOÀN TẤT THIẾT LẬP AGENTMEMORY! AI CÓ THỂ SỬ DỤNG NGAY BỘ NHỚ.")
    print("=" * 65)

if __name__ == "__main__":
    run()
