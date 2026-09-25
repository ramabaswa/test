Here's the walkthrough of every element in the NHI-Oasis-ComponentFlow.drawio diagram. I'll be completely truthful — including gaps and workarounds in the XML itself.

The 10 Components
#	Node	What it is	Position in layout
1	Human Users	Employees / Customers — the starting point for all requests	Far left, middle
2	Azure API Management	API facade: JWT validation, rate limits, API policy enforcement, request correlation. Green border = enforcement layer	Far left, below Human Users
3	Microsoft Entra ID / Azure IAM	Central identity provider: OAuth 2.0/OIDC, managed identities, service principals, RBAC, Conditional Access	Center-left, top
4	AI Gateway / MCP Gateway	AI agent routing, tool allow-list, prompt/response controls, MCP authorization context. Blue border = AI/agent flow	Center-left, bottom
5	Applications & Services	Web, mobile, backend APIs — the application layer	Center, top
6	Oasis Security Platform	Discovery, Governance, Policy, Detection, Remediation — the NHI governance engine	Center, middle
7	Enterprise Applications	Business APIs, microservices, SaaS / third-party integrations	Center, bottom
8	Oasis Database (cylinder)	Identity inventory, ownership, entitlements, risk posture, credential lifecycle	Right, top
9	Azure Key Vault (cylinder)	Secrets, certificates, rotation	Right, middle
10	Microsoft Sentinel / SOC	Audit trail, security alerts, incident investigation. Purple border = SOC/telemetry	Right, bottom
The 11 Numbered Sequence Steps (solid arrows — the request/response lifecycle)
Step 1: Human Users → Entra ID
Label: "Sign in / obtain token"
Hop: Exits the right side of Human Users (at 25% height), enters the left side of Entra ID (at 25% height). A straight horizontal arrow.
What happens: A human user — employee or customer — authenticates against Microsoft Entra ID. Entra validates credentials and issues an authentication token. This is the initial sign-in.

Step 2: Entra ID → Applications & Services
Label: "OAuth token or managed-identity token"
Hop: Exits the right side of Entra ID (at 40% height), routes upward and enters the bottom of Applications & Services. The edge has a waypoint at (680, 264) to route around the Oasis Platform box.
What happens: Entra ID issues a token to the application layer. This is either an OAuth 2.0 token (for user-delegated access) or a managed-identity token (for workload/service-to-service access). The token authorizes the application to act on behalf of the identity.

Step 3: Entra ID → Applications & Services
Label: "Access token with claims / scopes"
Hop: Exits the top of Entra ID (at 50% width), routes upward and enters the left side of Applications & Services (at 50% height). Has a source point override at (500, 242).
What happens: Entra ID issues a second token — the access token containing specific claims and scopes. This defines what the identity is authorized to do (which APIs, which permissions).
Truthful note: Steps 2 and 3 are closely related and somewhat redundant. Step 2 is the token issuance; Step 3 is the same token with its claims. In a real OIDC flow, these could be the same token or two separate tokens (ID token + access token). The diagram separates them to show two distinct concepts but this could be simplified.

Step 4: Human Users → Applications & Services
Label: "API request & bearer token"
Hop: Exits the top of Human Users, routes up to y=120, across to x=680, then down into the top of Applications & Services. Uses three waypoints to route over the top of the entire diagram.
What happens: The user makes an actual API request to the application, carrying the bearer token from Step 1. This is the application-level request — the user is calling the app.
Truthful note: This path bypasses API Management entirely. It represents direct application access (e.g., a web UI or mobile app hitting the backend directly). This is architecturally valid but means API policy enforcement (Step 5) is not in the path for this particular flow.

Step 5: Azure API Management → Entra ID (GREEN)
Label: "Validate token, enforce API policy"
Color: Green (#006600) — represents the API policy/enforcement flow
Hop: Exits the right side of APIM (at 25% height), routes up through waypoints at (230, 470) and (230, 302), then enters the left side of Entra ID (at 75% height).
What happens: Azure API Management validates the JWT bearer token against Entra ID's signing keys. It also enforces API-level policies — rate limits, quotas, IP restrictions. This is the enforcement gate before traffic reaches the application.

Step 6: Azure API Management → AI Gateway
Label: "Authorized AI / API request"
Hop: Exits the right side of APIM (at 60% height), routes down through waypoints at (230, 512) and (230, 616), then enters the left side of AI Gateway (at 30% height).
What happens: After APIM validates the token and enforces policy, the authorized request is forwarded to the AI Gateway / MCP Gateway. This is where AI agent traffic enters the governance layer.

Step 7: AI Gateway → Enterprise Applications
Label: "Controlled tool invocation"
Hop: Exits the right side of AI Gateway (at 30% height), enters the left side of Enterprise Applications (at 40% height). Straight horizontal arrow.
What happens: The AI Gateway evaluates the tool request against its allow-list and MCP authorization context. If the tool invocation is permitted, it forwards the request to Enterprise Applications (business APIs, microservices, SaaS integrations).

Step 8: Enterprise Applications → Azure Key Vault
Label: "Retrieve runtime secret / certificate"
Hop: Exits the right side of Enterprise Apps (at 50% height), enters the bottom of Azure Key Vault (at 50% width).
What happens: Enterprise Applications retrieve runtime secrets or certificates from Azure Key Vault. This is just-in-time secret retrieval — the application gets the credential it needs at runtime rather than having it embedded.

Step 9: Enterprise Applications → AI Gateway (return)
Label: "Data / action result"
Hop: Exits the left side of Enterprise Apps (at 70% height), routes through waypoints at (650, 613) and (650, 664), then enters the right side of AI Gateway (at 70% height). This is a reverse-direction arrow.
What happens: Enterprise Applications return the result of the tool invocation back to the AI Gateway. The response data flows back through the gateway.

Step 10: AI Gateway → API Management (GREEN)
Label: "Policy-filtered response"
Color: Green (#006600) — continues the API policy/enforcement flow
Hop: Exits the left side of AI Gateway (at 90% height — very bottom), routes through waypoint at (85, 688), then enters the bottom of API Management (at 25% width).
What happens: The AI Gateway applies prompt/response controls — filtering the response content. The filtered response goes back through API Management, which may apply additional response policies.

Step 11: AI Gateway → Human Users (BLUE)
Label: "Response"
Color: Blue (#000099) — represents the AI/MCP gateway flow
Hop: Exits the left side of AI Gateway (at 10% height — very top), routes through waypoints at (280, 590), (260, 590), (260, 340), (145, 340), then enters the bottom of Human Users (at 75% width). This is a complex routing path that goes around the left side of the diagram.
What happens: The final response is delivered back to the human user. The response has passed through the AI Gateway's filtering and APIM's policy enforcement.

The 5 Governance Dashed Lines (Oasis Security integration)
These dashed lines represent the identity governance and lifecycle integrations. Oasis Security operates as a side-channel governance platform — it is not inline in the request path.

Governance Line 1: Entra ID → Oasis Platform
Label: "Identity metadata, app registrations, service principals"
Style: Dashed line
Hop: Exits the right side of Entra ID (at 50% height), enters the left side of Oasis Platform (at 20% height).
What happens: Entra ID continuously sends identity metadata to the Oasis Security Platform. This includes app registrations, service principals, and managed identities. This is how Oasis discovers and inventories non-human identities.

Governance Line 2: AI Gateway area → Oasis Platform
Label: "Agent identities, tool permissions, execution events"
Style: Dashed line
Hop: This edge does not have a proper source node. It uses a manual sourcePoint at (500, 616) — which is approximately near the AI Gateway — and routes through waypoints at (500, 470) and (680, 470) to enter the bottom of Oasis Platform (at 50% width). The XML also declares target="node_oasis_platform" with a targetPoint at (580, 400).
What happens: The AI Gateway sends agent identities, tool permissions, and execution events to Oasis. This is how Oasis extends its governance to cover AI agents.
Truthful note: This edge is a workaround. In the XML, the source attribute is missing — only a sourcePoint coordinate is provided. Draw.io renders it as a floating edge starting from approximately (500, 616), which visually appears to originate from the AI Gateway area. This is not a clean node-to-node connection and is technically imprecise in the XML.

Governance Line 3: Oasis Platform → Oasis Database
Label: "Risk findings, ownership, least privilege recommendations"
Style: Dashed line
Hop: Exits the right side of Oasis Platform (at 30% height), enters the left side of Oasis Database (at 30% height). Straight horizontal arrow.
What happens: Oasis writes its analysis results to the Oasis Database — risk findings, ownership attribution, and least-privilege recommendations. The database is the persistent store for Oasis's intelligence graph.

Governance Line 4: Oasis Platform → Azure Key Vault
Label: "Rotation / revoke workflows"
Style: Dashed line
Hop: Exits the right side of Oasis Platform (at 60% height), enters the left side of Azure Key Vault (at 20% height).
What happens: Oasis sends automated remediation commands to Azure Key Vault — rotating exposed credentials, revoking compromised secrets, decommissioning unused certificates. When Oasis detects a risk (e.g., a leaked secret), it can directly trigger Key Vault rotation.

Governance Line 5: Oasis Platform → Entra ID (remediation loop)
Label: "Remediation / lifecycle actions"
Style: Dashed line
Hop: Exits the left side of Oasis Platform (at 60% height), enters the bottom of Entra ID (at 50% width). Reverse-direction arrow.
What happens: Oasis sends remediation actions back to Entra ID — disabling compromised service principals, removing excessive app role assignments, rotating client secrets, decommissioning unused identities. This closes the governance loop: Oasis discovers risk from Entra (Line 1), analyzes it, stores it (Line 3), and then sends remediation actions back to Entra (Line 5) and Key Vault (Line 4).

The 2 Telemetry Dashed Lines (SOC integration)
Telemetry Line 1: AI Gateway → Sentinel
Label: "Audit logs"
Color: Purple/magenta (#99004D) — represents audit/SOC telemetry
Style: Dashed line
Hop: Exits the bottom of AI Gateway (at 50% width), routes through waypoint at (390, 725), then enters the left side of Sentinel (at 50% height).
What happens: The AI Gateway forwards audit logs to Microsoft Sentinel — records of agent activity, tool invocations, policy decisions, and prompt/response interactions. This gives the SOC visibility into AI agent behavior.

Telemetry Line 2: Enterprise Applications → Sentinel
Label: "Risk alerts & findings"
Color: Purple/magenta (#99004D) — continues SOC telemetry
Style: Dashed line
Hop: Exits the right side of Enterprise Apps (at ~95% width / ~98% height — almost the corner), routes through waypoints at (859, 660) and (860, 743), then enters the left side of Sentinel (at 70% height). Uses exitPerimeter=0 which means the exit point is on the raw rectangle boundary, not the default perimeter.
What happens: Enterprise Applications send risk alerts and security findings to Sentinel — anomalous access patterns, failed authentication attempts, suspicious API calls. This is the application-layer telemetry that feeds SOC threat detection.
Truthful note: The exit point at (0.947, 0.982) is an unusual fractional exit — it's trying to exit from the very bottom-right corner of the Enterprise Apps box, which is a workaround to route the line cleanly to Sentinel below.
