Zone 1: Runtime Access Flow (top lane)
These 8 components form the live request/response path, laid out left to right.

1. Requesters (n_req)
Shape: Rectangle, gray fill, gray border

Position: x=40, y=60, 160x100

Contents: Human users, Workloads/services, AI agents/bots

Role: The origin point. All requests start here — whether from a human clicking a UI, a service calling an API, or an AI agent invoking a tool.

2. Microsoft Entra ID / Azure IAM (n_entra)
Shape: Rectangle, white fill, black border

Position: x=250, y=60, 190x120

Contents: OAuth 2.0/OIDC, Managed identities, Service principals, RBAC/Conditional Access

Role: Central identity provider. Validates who the requester is and issues tokens with claims/scopes. This is the authentication authority.

3. Azure API Management (n_apim)
Shape: Rectangle, light green fill, green border (#006600)

Position: x=490, y=60, 180x120

Contents: JWT validation, Rate limiting, API policy enforcement, Request correlation

Role: API gateway/enforcement layer. Validates the JWT token against Entra's signing keys, enforces rate limits and API policies. Green border marks this as the policy enforcement flow.

Color meaning: Green = API policy/enforcement

4. AI / MCP Gateway (n_gateway)
Shape: Rectangle, light blue fill, blue border (#3333FF)

Position: x=720, y=60, 190x120

Contents: Agent routing, Tool allow-list, Prompt/response controls, MCP authorization context

Role: AI agent governance gateway. Routes AI agent requests, enforces tool allow-lists, filters prompts and responses, manages MCP authorization context. Blue border marks this as the AI/MCP flow.

Color meaning: Blue = AI/MCP gateway flow

5. AuthZ / PDP (n_pdp)
Shape: Rectangle, light amber fill, amber border (#D6953A)

Position: x=960, y=60, 170x100

Contents: Policy decision point, Fine-grained authorization, Real-time evaluation

Role: The policy decision point. Makes real-time authorization decisions — evaluating whether the requester should be allowed to do what they're trying to do. Asterisk (*) means multiple products provide this capability.

New gap fill: This was missing from the original diagram.

6. Risk Confidence Gate (n_gate)
Shape: Rectangle, amber-yellow fill, amber border (#D6A000)

Position: x=960, y=180, 170x80 (directly below PDP)

Contents: High → allow, Low → human approval, Deny/revoke

Role: Risk-based gate between policy evaluation and access issuance. If risk confidence is high, access proceeds. If low, human approval is required. If risk is critical, deny or revoke.

New gap fill: This was missing from the original diagram — there was no explicit risk gate.

7. Workload Identity / mTLS (n_wlid)
Shape: Rectangle, light gray fill, gray border

Position: x=1170, y=60, 170x100

Contents: Short-lived crypto identities, Service mesh mTLS, SPIFFE/SVID

Role: Issues short-lived cryptographic identities for workloads. Uses service mesh mTLS for service-to-service authentication. Supports SPIFFE/SVID standards.

New gap fill: This was missing from the original diagram — there was no workload identity issuance step.

8. Enterprise Applications (n_entapps)
Shape: Rectangle, white fill, black border

Position: x=1390, y=60, 180x100

Contents: Business APIs, Microservices, SaaS/third-party APIs

Role: The business logic layer. These are the applications that actually execute the work — business APIs, microservices, and SaaS integrations.

9. Target Resources (n_target)
Shape: Rectangle, white fill, black border

Position: x=1620, y=60, 160x100

Contents: Databases, Storage/VMs, SaaS APIs, Cloud resources

Role: The end target — what the enterprise application is trying to access. Databases, storage accounts, VMs, SaaS APIs, cloud resources.

Zone 2: NHI Control Plane (right side)
This is the NHI governance engine — a dashed purple container with 6 sub-component boxes inside it. All shapes are rectangular.

Container (n_nhi_box)
Shape: Rectangle, lavender fill (#FAF5FF), purple dashed border, 2px stroke

Position: x=1820, y=50, 340x350

Role: The NHI governance and intelligence zone. Contains discovery, graph, risk scoring, governance, detection, and remediation capabilities.

Sub-component 1: Discovery & Inventory (n_disc)
Position: x=1835, y=80, 155x65

Products: Oasis, Astrix, Token, Entro, Clarity, SailPoint, Saviynt

Role: Discovers and inventories all non-human identities — service principals, managed identities, API keys, OAuth apps, AI agents, secrets, certificates. Continuous scanning across cloud, SaaS, CI/CD, and on-prem.

Sub-component 2: Identity Graph & Lineage (n_graph)
Position: x=2000, y=80, 155x65

Products: Token, P0, Entro, Opal

Role: Builds a graph of all NHI relationships — who created what, what accesses what, what credentials chain to what identities. Maps blast radius and privilege chains.

Sub-component 3: Risk / Posture Scoring (n_risk)
Position: x=1835, y=155, 155x65

Products: Oasis, Token, Clarity, Unosecur, P0, Nexis

Role: Scores the risk posture of each NHI — over-privilege, unused credentials, stale identities, exposed secrets. Feeds the Risk Confidence Gate.

Sub-component 4: Governance / Lifecycle (n_gov)
Position: x=2000, y=155, 155x65

Products: Saviynt, SailPoint, Nexis, Andromeda

Role: Lifecycle governance — provisioning, access reviews, recertification, compliance, audit reporting. IGA-style capabilities for machine identities.

Sub-component 5: Detection / Response (n_detect)
Position: x=1835, y=230, 155x65

Products: Oasis, Token, Entro, Unosecur, Astrix, Clarity

Role: Runtime threat detection for NHIs — anomalous access patterns, credential misuse, impossible travel, privilege escalation. Triggers incident response.

Sub-component 6: Remediation Orchestration (n_remediation)
Position: x=2000, y=230, 155x65

Products: Oasis, Clarity, Token, Entro, C1, Nexis

Role: Automated remediation — revoke credentials, rotate secrets, disable service principals, decommission unused identities. Red border marks this as the remediation zone.

NHI Graph / Inventory DB (n_nhidb)
Shape: Cylinder, yellow fill (#FFF2CC), gold border (#D6B656)

Position: x=1880, y=420, 160x90

Contents: Identities, Risk posture, Lineage

Role: Persistent database for the NHI intelligence graph. Stores the identity inventory, risk findings, ownership data, entitlements, and credential lifecycle records.

Azure Key Vault (n_kv)
Shape: Cylinder, yellow fill, gold border

Position: x=2070, y=420, 160x90

Contents: Secrets, Certificates, Rotation

Role: Azure's native secrets store. NHI remediation sends rotation/revoke commands here. Workload Identity retrieves runtime secrets/certs from here.

Zone 3: AAM Adjacent Domain (bottom)
This is the key new zone — visually separated from the NHI Control Plane. It has a pink dashed border (not purple) and is positioned below the runtime flow, not inside the NHI container.

AAM Container (n_aam_box)
Shape: Rectangle, pink fill (#FFF0F5), pink dashed border (#B8547C), 2px stroke

Position: x=40, y=560, 1200x180

Label: "Agent Access Management — governs AI agents, tool access, and autonomous sessions"

Role: AAM is part of the NHI domain but operates as an adjacent control plane for agentic access. The dashed border and pink color make it visually distinct from the NHI Control Plane's purple. The note below explicitly states: "AAM is part of the NHI domain but operates as an adjacent control plane for agentic access — not all NHI products provide full AAM capabilities."

AAM Capability 1: Agent Identity Registry (n_aam1)
Position: x=60, y=590, 170x80

Contents: Register/inventory AI agents, MCP servers, Agent lifecycle

Role: Maintains a registry of all AI agents and MCP servers — who they are, what they're authorized to do, their lifecycle state (active, suspended, decommissioned).

AAM Capability 2: Tool Permission Catalog (n_aam2)
Position: x=250, y=590, 170x80

Contents: Allow-list of tools, Per-agent scopes, Capability mapping

Role: Maintains the catalog of tools that AI agents can invoke. Maps which agent can use which tool, with what scope. This is the allow-list that the AI Gateway checks against.

AAM Capability 3: Intent / Task Context (n_aam3)
Position: x=440, y=590, 170x80

Contents: Task-level authorization, Goal/scope validation, Purpose-bound access

Role: Evaluates the intent behind an agent's request — is the task within the agent's authorized purpose? Is the scope of the request aligned with the declared goal? This is purpose-bound access, not just identity-bound.

AAM Capability 4: Runtime Guardrails (n_aam4)
Position: x=630, y=590, 170x80

Contents: Prompt injection defense, Output filtering, Token/rate limits

Role: Real-time guardrails on agent behavior — defending against prompt injection, filtering sensitive output, enforcing token consumption and rate limits per agent.

AAM Capability 5: Session Controls (n_aam5)
Position: x=820, y=590, 170x80

Contents: Session-bound credentials, Ephemeral tokens, Timeout/revocation

Role: Manages agent sessions — issuing session-bound credentials that expire, ephemeral tokens with short TTL, and the ability to revoke sessions in real-time.

AAM Capability 6: Agent-to-Agent / Agent-to-Tool AuthZ (n_aam6)
Position: x=1010, y=590, 210x80

Contents: Delegation chains, Mutual auth between agents, Tool invocation policies

Role: Authorizes interactions between agents and between agents and tools. Manages delegation chains (agent A delegates to agent B), mutual authentication, and tool invocation policies.

AAM Products
AAM primary: Astrix, C1.ai

AAM adjacent/integrating: Oasis, Token, Entro, P0, PlainID, Opal, Akeyless, Teleport

Truthful note: Not all 19 NHI products provide full AAM capabilities. Astrix and C1.ai are the primary AAM-focused products. The others provide adjacent controls that integrate with AAM (identity governance, authorization, secrets, workload identity).

Zone 4: Observability & Remediation (far right, below NHI)
Microsoft Sentinel / SOC (n_sentinel)
Shape: Rectangle, light red fill (#FFF0F0), dark red border (#99004D)

Position: x=1830, y=540, 280x120

Contents: SIEM audit trails, Security alerting, Incident investigation, Threat hunting

Role: The SOC's SIEM platform. Receives audit logs, risk alerts, and threat detection telemetry from the AI Gateway, Enterprise Apps, and NHI Detection. Sends incident response actions to the Remediation Targets box.

Remediation Targets (n_remtargets)
Shape: Rectangle, amber fill (#FFF8E1), amber border (#D6A000)

Position: x=1830, y=680, 280x110

Contents: Entra ID (disable/revoke SP), Key Vault (rotate secrets), APIM (block API keys), AI Gateway (revoke agent sessions)

Role: Centralized remediation action router. When Sentinel detects an incident, it triggers remediation actions here — which then dispatch to the specific enforcement points: Entra ID, Key Vault, APIM, and AI Gateway.

New gap fill: The original diagram only showed Oasis → Entra and Oasis → Key Vault remediation. This version shows the full remediation target set including APIM and AI Gateway.

The 11 Sequence Flow Edges (solid, numbered)
These form the primary request lifecycle — steps 1 through 11.

Edge e1: Requesters → Entra ID
Label: "1. Authenticate"

Color: Black (#333333), solid

Hop: Exits right side of Requesters (50% height), enters left side of Entra ID (50% height)

What happens: The requester — human, workload, or AI agent — authenticates against Microsoft Entra ID. Entra validates credentials (password, certificate, federated SSO) and prepares to issue a token.

Edge e2: Entra ID → APIM
Label: "2. Token issued (claims / scopes)"

Color: Black, solid

Hop: Exits right side of Entra ID (50% height), enters left side of APIM (50% height)

What happens: Entra ID issues a token containing claims and scopes. This is the single token issuance step — the original diagram had two redundant edges (steps 2 and 3) for essentially the same action. This version consolidates them into one clean step.

Edge e3: APIM → AI Gateway
Label: "3. Authorized request"

Color: Green (#006600), solid

Hop: Exits right side of APIM (50% height), enters left side of AI Gateway (50% height)

What happens: After APIM validates the token and enforces API policies (step 4 below), the authorized request is forwarded to the AI/MCP Gateway. Green marks this as part of the API enforcement flow.

Edge e4: APIM → Entra ID (reverse)
Label: "4. Validate token + policy"

Color: Green (#006600), solid

Hop: Exits left side of APIM (80% height — near bottom), enters right side of Entra ID (80% height). Reverse-direction arrow.

What happens: Azure API Management validates the JWT bearer token against Entra ID's signing keys and enforces API-level policies (rate limits, quotas, IP restrictions). This is a callback to Entra — APIM asks Entra to confirm the token is valid.

Edge e5: AI Gateway → AAM (Agent Identity Registry)
Label: "5. Request agent / tool / session context"

Color: Pink (#B8547C), dashed

Hop: Exits bottom of AI Gateway (50% width), enters top of AAM Agent Identity Registry (50% width)

What happens: The AI Gateway asks the AAM zone for context about the agent — its identity, what tools it's allowed to use, and its session state. This is the first AAM integration point in the sequence.

New gap fill: This edge connects the runtime flow to the AAM zone — the original diagram had no AAM at all.

Edge e6: AAM (Intent/Task Context) → AuthZ/PDP
Label: "6. Intent + tool permissions"

Color: Pink (#B8547C), dashed

Hop: Exits right side of AAM Intent/Task Context box (50% height), enters left side of PDP (50% height)

What happens: AAM passes the agent's intent, task context, and tool permissions to the Policy Decision Point. The PDP now has both the identity claims (from Entra) and the agent context (from AAM) to make an authorization decision.

New gap fill: This shows how AAM feeds into the authorization decision — the original had no PDP or AAM.

Edge e7: PDP → Risk Confidence Gate
Label: "7. Evaluate risk"

Color: Amber (#D6A000), solid

Hop: Exits bottom of PDP (50% width), enters top of Risk Confidence Gate (50% width). Straight vertical arrow.

What happens: The PDP sends the authorization request to the Risk Confidence Gate for risk evaluation. The gate checks the NHI risk posture (step 8) and decides: high confidence → allow, low confidence → human approval, critical risk → deny/revoke.

New gap fill: This is the explicit risk gate that was missing from the original.

Edge e8: Risk Gate → NHI Risk/Posture Scoring
Label: "8. Consult NHI graph + risk posture"

Color: Purple (#9673A6), dashed

Hop: Exits right side of Risk Gate (50% height), enters left side of NHI Risk/Posture Scoring box (50% height)

What happens: The Risk Confidence Gate queries the NHI Control Plane's risk scoring engine — pulling the identity's risk posture, blast radius, privilege level, and behavioral history from the NHI Graph. This is how the gate gets the intelligence it needs to make a confidence decision.

New gap fill: This connects the runtime risk gate to the NHI intelligence layer — the original had no risk gate or NHI graph consultation.

Edge e9: PDP → Workload Identity
Label: "9. Issue short-lived credential"

Color: Black, solid

Hop: Exits right side of PDP (50% height), enters left side of Workload Identity/mTLS box (50% height)

What happens: After the PDP and Risk Gate approve the request, a short-lived credential is issued via the Workload Identity component. This is a just-in-time credential — not a standing secret. Could be a SPIFFE SVID, an mTLS certificate, or a short-lived OAuth token.

New gap fill: This is the credential issuance step that was missing from the original — the original jumped from AI Gateway directly to Enterprise Apps without a credential issuance step.

Edge e10: Workload Identity → Enterprise Apps
Label: "10. Access target resource"

Color: Black, solid

Hop: Exits right side of Workload Identity (50% height), enters left side of Enterprise Apps (50% height)

What happens: The workload uses its short-lived credential to access Enterprise Applications — the business APIs, microservices, and SaaS integrations that execute the actual work.

Edge e11: Enterprise Apps → Target Resources
Label: "11. Execute API / data access"

Color: Black, solid

Hop: Exits right side of Enterprise Apps (50% height), enters left side of Target Resources (50% height)

What happens: Enterprise Applications access the final target resources — databases, storage, VMs, SaaS APIs, cloud resources. This is the end of the forward request path.

The 5 NHI Governance Dashed Edges
These edges connect the runtime flow to the NHI Control Plane. They are side-channel integrations — NHI governance is not inline in the request path.

Edge g1: Entra ID → NHI Discovery
Label: "Identity metadata, app registrations, service principals"

Color: Gray (#666666), dashed

Hop: Exits right side of Entra ID (30% height), enters left side of NHI Discovery & Inventory (50% height)

What happens: Entra ID continuously streams identity metadata to the NHI Control Plane — app registrations, service principals, managed identities, OAuth app configurations. This is how NHI discovers and inventories non-human identities. The NHI platform reads from Entra's directory to build its inventory.

Edge g2: NHI Identity Graph → NHI Graph DB
Label: "Data sync"

Color: Gray, dashed

Hop: Exits right side of Identity Graph & Lineage (50% height), enters top of NHI Graph DB cylinder (50% width)

What happens: The NHI Control Plane writes its intelligence graph to the persistent database — identity records, relationships, lineage, blast radius data, ownership. This is the persistence layer for NHI intelligence.

Edge g3: NHI Remediation → Key Vault
Label: "Rotation / revoke"

Color: Gray, dashed

Hop: Exits right side of Remediation Orchestration (50% height), enters top of Azure Key Vault (50% width)

What happens: When NHI remediation detects a risk (e.g., exposed secret, compromised credential), it sends rotation/revoke commands to Azure Key Vault. This is the automated remediation path for secrets and certificates.

Edge g4: NHI Remediation → Entra ID (remediation loop)
Label: "Remediation: disable / revoke SP"

Color: Red (#B85450), dashed

Hop: Exits left side of Remediation Orchestration (50% height), enters right side of Entra ID (50% height). Reverse-direction arrow spanning the full width of the diagram.

What happens: NHI remediation sends actions back to Entra ID — disabling compromised service principals, removing excessive app role assignments, revoking client secrets. This closes the governance loop: NHI discovers from Entra (g1), analyzes risk (g2, e8), and sends remediation back to Entra (g4) and Key Vault (g3).

Color: Red — this is a remediation action, not just a governance sync.

Edge g5: Workload Identity → Key Vault
Label: "Retrieve secret / cert"

Color: Gray, dashed

Hop: Exits right side of Workload Identity (50% height), enters top of Azure Key Vault (50% width)

What happens: The Workload Identity component retrieves runtime secrets or certificates from Azure Key Vault. This is the just-in-time secret retrieval — the workload gets its credential at runtime rather than having it embedded. This connects to step 9 (credential issuance).

The 4 AAM Integration Dashed Edges
These edges connect the AAM zone to the runtime flow and the NHI Control Plane. They are pink dashed — distinct from the gray NHI governance edges and the red remediation edges.

Edge a1: AI Gateway → AAM Tool Permission Catalog
Label: "Tool allow-list sync"

Color: Pink (#B8547C), dashed

Hop: Exits bottom of AI Gateway (25% width), enters top of AAM Tool Permission Catalog (50% width)

What happens: The AI Gateway syncs its tool allow-list with the AAM Tool Permission Catalog. When the gateway needs to check if an agent can invoke a specific tool, it queries AAM's catalog. This is a bidirectional sync — AAM updates the allow-list, and the gateway enforces it.

Edge a2: AAM Session Controls → AI Gateway
Label: "Session credential"

Color: Pink, dashed

Hop: Exits left side of AAM Session Controls (50% height), enters bottom of AI Gateway (75% width). Reverse-direction arrow.

What happens: AAM Session Controls issue session-bound credentials back to the AI Gateway. These are ephemeral tokens with short TTL that the gateway uses for the duration of an agent session. When the session ends or is revoked, the credential expires.

Edge a3: AAM Agent-to-Agent AuthZ → PDP
Label: "Delegation policy"

Color: Pink, dashed

Hop: Exits right side of AAM Agent-to-Agent/Tool AuthZ (50% height), enters top of PDP (50% width)

What happens: AAM sends delegation chain policies to the PDP — rules about which agents can delegate to other agents, what tools can be invoked on behalf of another agent, and mutual authentication requirements between agents.

Edge a4: AAM → NHI Graph DB
Label: "Agent identity sync"

Color: Pink, dashed

Hop: Exits right side of AAM Agent-to-Agent/Tool AuthZ (50% height), enters left side of NHI Graph DB (50% height)

What happens: AAM syncs agent identity data to the NHI Graph — agent registrations, tool permissions, session history, delegation chains. This is how the NHI Control Plane gets visibility into AI agent identities and their access patterns. The NHI graph now contains both traditional NHIs (service principals, managed identities) and AI agent identities.

The 7 Telemetry & Remediation Edges
These edges connect the observability and remediation zone to the rest of the diagram. They are purple/magenta dotted (telemetry) and red dashed (remediation actions).

Edge t1: AI Gateway → Sentinel
Label: "12. Audit logs"

Color: Purple/magenta (#99004D), dashed

Hop: Exits right side of AI Gateway (50% height), enters left side of Sentinel (30% height)

What happens: The AI Gateway forwards audit logs to Microsoft Sentinel — records of agent activity, tool invocations, policy decisions, prompt/response interactions, and authorization outcomes. This gives the SOC visibility into AI agent behavior.

Edge t2: Enterprise Apps → Sentinel
Label: "Risk alerts & findings"

Color: Purple/magenta, dashed

Hop: Exits right side of Enterprise Apps (50% height), enters left side of Sentinel (50% height)

What happens: Enterprise Applications send risk alerts and security findings to Sentinel — anomalous access patterns, failed authentication attempts, suspicious API calls, privilege escalation attempts.

Edge t3: NHI Detection → Sentinel
Label: "Threat detection"

Color: Purple/magenta, dashed

Hop: Exits right side of NHI Detection/Response (50% height), enters left side of Sentinel (70% height)

What happens: The NHI Control Plane's detection engine forwards threat detections to Sentinel — anomalous NHI behavior, credential misuse, impossible travel, privilege escalation. Sentinel correlates these with other security signals for incident investigation.

Edge t4: Sentinel → Remediation Targets
Label: "Incident response"

Color: Purple/magenta, dashed

Hop: Exits bottom of Sentinel (50% width), enters top of Remediation Targets (50% width). Straight vertical arrow.

What happens: When Sentinel confirms a security incident, it triggers the Remediation Targets box to dispatch remediation actions. This is the SOC's incident response trigger.

Edge t5: Remediation Targets → Entra ID
Label: "12. Remediate: revoke / rotate / disable"

Color: Red (#B85450), dashed

Hop: Exits left side of Remediation Targets (50% height), enters bottom of Entra ID (50% width)

What happens: Remediation dispatches actions to Entra ID — disabling compromised service principals, revoking OAuth grants, removing app role assignments, rotating client secrets. This is step 12 — the final remediation action.

Edge t6: Remediation Targets → Key Vault
Label: "Rotate secrets"

Color: Red, dashed

Hop: Exits top of Remediation Targets (50% width), enters bottom of Azure Key Vault (50% width)

What happens: Remediation dispatches secret rotation commands to Azure Key Vault — rotating exposed credentials, revoking compromised certificates, decommissioning unused secrets.

Edge t7: Remediation Targets → AI Gateway
Label: "Revoke agent session"

Color: Red, dashed

Hop: Exits left side of Remediation Targets (20% height), enters bottom of AI Gateway (50% width)

What happens: Remediation dispatches session revocation to the AI Gateway — terminating active AI agent sessions, revoking session-bound credentials, blocking further tool invocations from the compromised agent.

New gap fill: The original diagram only remediated via Entra ID and Key Vault. This adds AI Gateway session revocation as a remediation target.
