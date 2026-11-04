# [Update: 04/11/2026 11:45]
# Tự động thiết lập AgentMemory MCP cho Antigravity trên Windows (1-Click)
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "  🚀 KÍCH HOẠT TỰ ĐỘNG BỘ NHỚ VĨNH VIỄN AGENTMEMORY (WINDOWS)    " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pyScript = Join-Path $scriptDir "setup_agentmemory.py"

if (Get-Command python -ErrorAction SilentlyContinue) {
    python $pyScript
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    py -3 $pyScript
} else {
    Write-Host "[!] Không tìm thấy Python trong PATH. Vui lòng cài đặt Python hoặc Node.js." -ForegroundColor Red
}
