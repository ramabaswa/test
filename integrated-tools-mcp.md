Phase 1: Request Ingress & Pre-Processing (The LLM Gateway)
The LLM Gateway intercepts the user interface session and normalizes incoming client traffic before any model reasoning occurs.

Application Layer / Veracode: Performs strict UI-level sanitization, input validation, and prevents Cross-Site Scripting (XSS) or CSRF at the user interaction boundary.

Okta (External) / Azure Identity (Internal): Enforces mandatory client authentication and validates OAuth tokens carrying state parameters to verify user identity.

AWS API Gateway: Rejects volumetric denial-of-service threats and manages initial API Rate Limiting for the inbound traffic.

Phase 2: Context Evaluation & Guardrails (The AI Gateway)
The AI Gateway acts as a firewall between the user's prompt and the core LLM execution engine, ensuring malicious data doesn't poison the model's reasoning.

Noma.security: Inspects the prompt payload in real-time to detect Prompt Injection Defense signatures and block malicious instruction sets.

Netskope: Scans the incoming context stream for Sensitive Data Identification, applying dynamic redaction or data filtering policies before it reaches the model.

TrueFoundry (System Prompt Protection): Wraps the LLM invocation with unalterable system prompts to preserve context isolation and prevent jailbreaking.

GitHub Pipeline (SBOM, SAST) + Veracode: Continually verifies the integrity and updates of the internal LLM execution application layer code via automated supply chain checks.

Phase 3: Model Intent Interception & Discovery (The MCP Gateway Boundary)
The LLM processes the query and decides it needs to execute a tool. It emits a standardized JSON-RPC request (tools/call), which is caught by the MCP Gateway (TrueFoundry).  

TrueFoundry (Gateway & Registry): Functions as the primary MCP Gateway; it intercepts the tools/call command and looks up the target tool schema within the immutable tool registry directory.

TrueFoundry (Tool Invocation Limits): Validates the specific tool call against predefined execution quotas and enforces API Rate Limiting tailored strictly to agent behaviors.

Noma.security (Malicious MCP Detection): Validates the tool's runtime schema from the registry to ensure it has not suffered from tool poisoning or supply chain modification.

TrueFoundry + Noma (Risk-Based Approval): Computes a risk score based on the action; if the tool modifies critical state, it pauses execution and signals the application layer to prompt for explicit human confirmation.

Phase 4: Token Exchange & Access Control (The MCP Gateway Core)
The tool call is approved by the gateway, which now establishes a highly secure, transient authorization context to talk to the target MCP Server.

Azure Identity / Okta (Scope Limitation): Limits the authorization tokens strictly to the minimum required scopes needed for that specific tool instance.

AWS IAM / Azure Identity (Least Privilege): Exchanges the generic gateway identity for a hyper-restricted, role-based token mapped directly to the target environment resources.

AWS IAM / SPIFFE (via ROSA): Injects a cryptographically verifiable Service Identity Authentication token into the network request packet to prove the gateway is the origin.

CyberArk / Conjur: Rotates and retrieves backend API keys or environmental secret parameters on the fly, injecting them securely into the request context.

AWS / Azure (TLS / Certs): Formats the outbound communication into secure, enterprise-grade encrypted protocols to establish trusted server-to-server verification.

Phase 5: Containerized Execution & Telemetry (The MCP Target Server Layer)
The MCP Gateway routes the request to the target distributed MCP Server operating inside the runtime environment.

TrueFoundry / ROSA Containers (Instance Isolation): Spawns or calls the tool within a locked-down, single-tenant Kubernetes namespace isolation environment.

ROSA (Resource Limits): Enforces rigid CPU and memory ceilings at the pod level to prevent an agent from triggering infinite-loop code or platform denial of service.

AWS KMS / AWS Platform: Restricts the container's background persistence lifecycle, validating data isolation at-rest, secure boot compliance, and data encryption.

Wiz: Continuously evaluates the host infrastructure security posture and performs automated infrastructure risk assessments on the ROSA cluster nodes.

CrowdStrike (EDR/XDR) + Wiz: Monitors the running container process memory for abnormal background execution behaviors or malware indicators.

Noma.security (Third-Party Response Security): Inspects the raw data payload returning from the tool/external service to ensure the response doesn't contain injected malicious payloads.

AWS CloudWatch / BlinkOps / SIEM: Streams all operation logs, client logging, and security events into a centralized audit vault.

BlinkOps Alerts: Monitors the centralized log stream for anomaly detection; if a security exception occurs, it fires automated playbooks to instantly drop connection tokens and isolate the compromised container namespace
