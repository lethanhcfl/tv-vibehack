<!-- [Update: 04/11/2026 11:35]
Tích hợp cấu hình Agent Memory (agentmemory) đồng bộ toàn hệ sinh thái -->

# Hướng dẫn Agent (Agent Guidelines)

<!-- agentmemory:start -->
## Agent memory (agentmemory)

You have persistent long-term memory via the agentmemory MCP server. Tools: , , , .

- At the START of a task, call  (or ) with the task context to load relevant past decisions, fixes, and preferences before asking the user to repeat anything.
- When you learn something durable (a decision, a fix, a gotcha, a user preference, a project convention), call  to persist it.
- Prefer recalling over re-deriving, and save concise reusable facts rather than transcripts.
<!-- agentmemory:end -->
