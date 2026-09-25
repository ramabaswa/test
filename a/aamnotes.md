How to Read the Sequence
The diagram flows in a U-shape — top row left-to-right (1→5), then down, then bottom row right-to-left (6→10), then a feedback loop back up to 1. This makes the sequence clear:

Phase 1-2: Registration & Authorization (top row, left to right)
Component 1: Agent Identity Registry — registers every AI agent, assigns it a unique identity (SPIFFE ID or OAuth client), tracks its lifecycle state (active/suspended/decommissioned), maps it to an owner and team, and federates the identity to Entra ID. This runs at onboarding time, before any request is made.

Arrow 1→2: "agent registered" — once the agent is registered, its identity is passed to the Tool Permission Catalog so permissions can be defined.

Component 2: Tool Permission Catalog — maintains the catalog of available tools (APIs, MCP tools, functions), maps which agent can invoke which tool, defines scopes (read/write/admin per tool), and versions the allow-list for audit purposes. This also runs at setup time.

Arrow 2→3: "tool allow-list" — the tool permissions are available for runtime evaluation.

Component 3: Intent / Task Context — at runtime, when an agent makes a request, this component parses the intent from the request, validates it against the agent's declared purpose, checks if the task scope is within authorized bounds, and enriches the context with risk posture and delegation info. It assembles a "decision package" for the PDP.

Arrow 3→4: "decision package" — the full context (agent ID + tool + intent + scope + risk + delegation) is sent to the Policy Decision Point.

Component 4: Policy Decision Point (AuthZ) — evaluates the decision package against policies. Checks delegation chains (is the agent acting on behalf of a user?), enforces rate limits and quotas, applies conditional access constraints (geo, time, device), and outputs a decision: allow, deny, or conditional (step-up approval required).

Arrow 4→5: "allow decision" — if the PDP allows the request, the decision is passed to Credential Issuance.

Component 5: Credential Issuance — issues a session-bound, short-lived credential (OAuth/JWT or SPIFFE SVID mTLS cert). The credential is scope-limited (only for approved tools) and delivered to the agent via the AI Gateway. No standing credentials — just-in-time issuance only.

Arrow 5→6: "credential issued" (vertical, downward) — the credential flows from the top row to the bottom row, entering the Runtime Guardrails component.

Phase 3-4: Execution & Post-Execution (bottom row, right to left)
Component 6: Runtime Guardrails — enforces real-time controls during tool execution: prompt injection defense, output filtering (redact sensitive data), tool invocation logging (record every call), and resource limits (token/API/cost limits per agent). This is the inline enforcement layer.

Arrow 6→7: "session started" — the guarded tool execution starts a session, which is tracked by Session Lifecycle Management.

Component 7: Session Lifecycle Management — tracks the active session (start time, duration, tools used, data accessed), enforces session timeout (auto-expire idle sessions), supports real-time session revocation, and handles credential refresh for continuing sessions. Session state machine: Created → Active → Idle → Expired/Revoked.

Arrow 7→8: "delegation context" — if the agent delegates to another agent, the session context is passed to Agent-to-Agent AuthZ.

Component 8: Agent-to-Agent AuthZ — validates delegation chains (Agent A → Agent B → Tool C), performs mutual authentication between agents (mTLS), enforces tool invocation policies (which tool can be called in what context), and validates cross-agent trust boundaries. Maintains a full audit trail of every delegation.

Arrow 8→9: "all activity logged" — all agent activity (tool calls, decisions, delegations) flows to Telemetry & Audit.

Component 9: Telemetry & Audit — logs all activity, builds behavioral baselines for agents (what does "normal" look like for each agent?), detects anomalies (agent deviating from baseline), forwards to SIEM/Sentinel for correlation, and maintains compliance evidence for SOC2/ISO 27001/AI Act.

Arrow 9→10: "anomaly detected" (red) — if an anomaly is detected, it triggers Remediation.

Component 10: Remediation — revokes active sessions, disables the agent identity in the registry, blocks tool access (removes from allow-list), rotates compromised credentials, and notifies SOC/owner with ITSM tickets.

Arrow 10→1: "closure: update agent state" (red dashed, vertical upward) — remediation updates the agent's lifecycle state in the Registry (e.g., from "active" to "suspended"), closing the loop. This means the next time the agent tries to make a request, the Registry will reject it at Component 1.
