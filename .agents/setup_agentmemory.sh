#!/usr/bin/env bash
# [Update: 04/11/2026 11:45]
# Tự động thiết lập AgentMemory MCP cho Antigravity trên macOS / Linux
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if command -v python3 >/dev/null 2>&1; then
    python3 "$SCRIPT_DIR/setup_agentmemory.py"
elif command -v python >/dev/null 2>&1; then
    python "$SCRIPT_DIR/setup_agentmemory.py"
else
    echo "[!] Không tìm thấy Python trong PATH."
    exit 1
fi
