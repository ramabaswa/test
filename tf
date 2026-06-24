## Enterprise POC Guideline: AWS AgentCore & TrueFoundry Coexistence Matrix

### 1. Summary & Objective of the POC

The objective of this Proof of Concept (POC) is to evaluate a **Hybrid Control Plane architecture** that leverages **AWS Bedrock AgentCore** as the core multi-agent execution environment alongside **TrueFoundry** as the enterprise cross-model AI gateway, governance fabric, and tool/MCP repository.

While both platforms feature overlapping gateway capabilities, this POC establishes a clear separation of concerns to avoid architectural competition. AWS AgentCore is treated as the **Build-to-Scale Framework & Execution Runtime**, whereas TrueFoundry serves as the **Global AI Policy, Discovery, Cost Governance, and Multi-Cloud Abstraction Layer**.

```
   ┌─────────────────────────────────────────────────────────────┐
   │             TrueFoundry Enterprise Control Plane            │
   │  (Global Cost Enforcement, Guardrails, Agent/MCP Catalog)   │
   └──────────────────────────────┬──────────────────────────────┘
                                  │ (Unified Model/Tool Routing)
                                  ▼
   ┌─────────────────────────────────────────────────────────────┐
   │               AWS Bedrock AgentCore Runtime                 │
   │   (MicroVM Execution, Session State, Memory Management)     │
   └─────────────────────────────────────────────────────────────┘

```

#### Shared & Dedicated Responsibilities

| Capability | AWS Bedrock AgentCore | TrueFoundry | Operational Boundary |
| --- | --- | --- | --- |
| **Agent Execution Loop** | **Dedicated:** Spawns sandboxed MicroVM runtimes, short/long-term memory, state machine resolution. | *None* | AgentCore owns the compute lifecycle of the running agent. |
| **Model Ingress / Egress** | *None* (Bypasses default LiteLLM approach). | **Dedicated:** Cross-provider model fallback, token caching, uniform OpenAI spec routing. | AgentCore calls the TrueFoundry AI Gateway endpoint as its `base_url`. |
| **MCP & Tool Cataloging** | *Consumer:* Dynamically binds tools to specific execution instances. | *Provider:* Centralized registration, semantic tool indexing, OAuth injection. | TrueFoundry acts as the registry; AgentCore queries TrueFoundry to discover and execute tools. |
| **Cost & FinOps Management** | *Local tracking:* Token counts per session. | **Dedicated:** Hard dollar budgets, team-level cost back-billing, cross-cloud financial rollups. | TrueFoundry intercepts the API calls to enforce hard limits and prevent runaway recursive loops. |
| **Guardrails & Security** | *AWS Context:* IAM bounds, VPC endpoint constraints. | *Data Context:* PII scrubbing (Presidio/Akto), real-time malicious input blocking. | TrueFoundry filters inputs/outputs at the API boundary; AgentCore handles infrastructure security. |

---

## 2. Technical Use Cases

### Use Case 1: Agent Discovery & Capability Matching

* **Description:** When an agent requires an external capability (e.g., retrieving an insurance claim folder), it shouldn't hardcode tool endpoints.
* **TrueFoundry Role:** Exposes a centralized semantic directory of available enterprise tools, OpenAPI schemas, and Model Context Protocol (MCP) servers.
* **AgentCore Role:** Queries TrueFoundry’s discovery API during its planning phase to find the correct tool structure, then maps the tool schema to its local Action Group.

### Use Case 2: Federated Agent Registration Catalog

* **Description:** Cataloging built agents across different business units to prevent duplication.
* **TrueFoundry Role:** Serves as the organization-wide System of Record (Catalog) for all developed agents, versioned prompts, and downstream metadata.
* **AgentCore Role:** Registers its deployed agent manifests into TrueFoundry upon pipeline deployment.

### Use Case 3: Polyglot Protocol Support & Multi-Model Fallbacks

* **Description:** Agents executing inside AWS AgentCore need to switch seamlessly between AWS Bedrock models, Azure OpenAI instances, or self-hosted open-source models inside a private VPC.
* **TrueFoundry Role:** Acts as the single OpenAI-compatible endpoint. It handles sub-5ms protocol translation, load balancing, and automatic fallback if Bedrock encounters rate limits or outages.
* **AgentCore Role:** Targets TrueFoundry as its singular upstream LLM provider, eliminating the need to manage individual provider SDKs.

### Use Case 4: Cost Management (Real-Time Budget Enforcement & Reporting)

* **Description:** Agentic loops can recursively iterate, driving up astronomical token costs before a process finishes.
* **TrueFoundry Role:** Monitors token consumption *in-flight*. It enforces hard dollar limits by user, team, or specific agent ID, throwing an immediate 403 blocking error back to the application layer if a threshold is crossed.
* **AgentCore Role:** Gracefully handles the budget exhaustion exception thrown by TrueFoundry, checkpoints the current agent session state to storage, and alerts the user.

### Use Case 5: Dynamic Identity & OAuth 2.0 Token Injection

* **Description:** When an agent executes a tool on behalf of a specific user (e.g., pulling a patient chart), it must pass the appropriate security tokens.
* **TrueFoundry Role:** Uses its MCP Gateway module to perform On-Behalf-Of (OBO) authentication mapping, securely injecting the user's OAuth 2.0 or bearer tokens into the outgoing tool request.
* **AgentCore Role:** Passes the initial end-user identity context down through the execution chain.

### Use Case 6: Regulated Data Guardrails (PHI/PII Extraction)

* **Description:** Inspecting inputs and outputs for sensitive compliance leaks (HIPAA/PHI) before data leaves the environment or is processed by a model.
* **TrueFoundry Role:** Intercepts payload contents using inline sidecar egress hooks (e.g., Akto/Presidio integration) to mask or block social security numbers, medical record numbers, or proprietary claims details.
* **AgentCore Role:** Focuses on processing unmasked, safe data within its secure execution memory.

---

## 3. High-Level Activities & RACI Matrix

### High-Level Activities

1. **Architecture & Security Guardrail Definition:** Establish the cross-VPC networking patterns between the AWS-native AgentCore environment and the Kubernetes cluster hosting TrueFoundry.
2. **Identity Control Setup:** Map AWS Cognito/IAM roles to TrueFoundry Virtual Account Tokens and project spaces.
3. **Gateway & Abstraction Configuration:** Point AgentCore's underlying translation configs to TrueFoundry’s unified API endpoints.
4. **MCP Server & Tool Mounting:** Register baseline Enterprise tools into TrueFoundry's registry and present them to AgentCore.
5. **FinOps & Policy Test Scenarios:** Trigger simulated runaway agent loops to validate TrueFoundry’s real-time cost throttling and billing dashboards.
6. **End-to-End Execution & Lakehouse Ingestion:** Execute a full clinical or claims automation scenario, routing telemetry data directly from both systems into the corporate data lakehouse.

### RACI Matrix

* **R**esponsible: Does the work.
* **A**ccountable: Final approving authority (Only one per activity).
* **C**onsulted: Provides input/expertise.
* **I**nformed: Updated on progress.

| POC Activity | Security (PHI/PII) | Identity Team | Platform Team | AI Team | Business Unit |
| --- | --- | --- | --- | --- | --- |
| Define Network Boundaries & Air-gapping | C | C | **A** / **R** | R | I |
| Configure Identity Federation & OBO Auth | C | **A** / **R** | R | C | I |
| Deploy TrueFoundry Control Plane & Gateways | I | I | **A** / **R** | C | I |
| Author Agentic Code inside AgentCore | I | I | C | **A** / **R** | C |
| Establish PHI/PII Guardrail Rules | **A** / **R** | I | R | R | C |
| Define FinOps Limits & Cost Center Mapping | I | I | C | R | **A** / **R** |
| Run E2E Use Cases & Evaluate Metrics | I | I | I | **A** / **R** | **R** |

---

## 4. Timeline (6-Week Target)

```
[ Week 1-2: Core Infra & Identity ] ──► [ Week 3-4: Tool Integration & Security ] ──► [ Week 5-6: FinOps, Testing & Review ]

```

### Weeks 1–2: Infrastructure Foundations & Identity Alignment

* Provision isolated AWS sandbox environments.
* Deploy TrueFoundry into the targeted cluster environment; configure base model access.
* Establish OIDC/IAM integrations connecting AgentCore runtimes to TrueFoundry tenant keys.

### Weeks 3–4: Tooling Integration & Security Baseline

* Deploy initial test MCP servers and document schemas into TrueFoundry.
* Configure AgentCore action groups to query TrueFoundry's tool catalog.
* Implement TrueFoundry input/output guardrails for automated PHI/PII masking.

### Weeks 5–6: FinOps Validation, Execution & Success Evaluation

* Conduct simulation testing (failure routing, regional fallbacks, hard cost cap overrides).
* Validate end-to-end telemetry pipeline streaming into the corporate Lakehouse.
* Compile data, evaluate against success criteria, and deliver final technical recommendation.

---

## 5. Success Criteria

### Quantitative Metrics

* **Latency Overhead:** TrueFoundry’s inline AI gateway must add $\le 10\text{ ms}$ of latency overhead to the raw LLM inference time under standard load.
* **Cost Containment Accuracy:** 100% of runaway recursive loops must be halted within 1 request of exceeding the preset dollar threshold.
* **Telemetry Synchronization:** 100% of execution traces from AgentCore and prompt metrics from TrueFoundry must successfully correlate via a shared `trace_id` inside the corporate Data Lakehouse.

### Qualitative Metrics

* **Developer Ergonomics:** The AI team can swap the backend model from Bedrock to an external provider via TrueFoundry’s UI *without rewriting or redeploying* the AgentCore application code.
* **Compliance Sign-off:** The Security/PHI team verifies that zero unmasked health records leave the designated secure data plane boundaries during tool operations.

---

## 6. Assumptions

### AWS AgentCore

* The enterprise will utilize the serverless, containerized AgentCore runtime environments for executing agent nodes, acknowledging that session states and agent-to-agent (A2A) topologies will live natively within AWS compute infrastructure.

### Tools & Lakehouse Integration

* The data plane telemetry (OpenTelemetry formats) generated by both TrueFoundry and AgentCore can be normalized and systematically ingested into the enterprise Data Lakehouse (e.g., Databricks/Snowflake via AWS S3) for long-term historical reporting.
* Downstream enterprise applications (e.g., core systems) will expose standard OpenAPI or MCP endpoints readable by TrueFoundry.

### Environments & Sandboxing

* All POC activities will happen within a non-production, network-isolated AWS Sandbox environment.
* Synthesized, de-identified datasets will be utilized exclusively during the testing phase to prevent accidental exposure of live production records prior to final guardrail validation.
