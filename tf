# Proof of Concept (POC) Guidelines: TrueFoundry in an AWS AgentCore Environment

---

## 1. Summary & Objective of the POC

The objective of this Proof of Concept (POC) is to evaluate and establish **TrueFoundry** as the centralized **Control, Infrastructure Governance, and Marketplace Plane** for enterprise AI workloads, while leveraging **AWS Bedrock AgentCore** as the low-latency, serverless **Agent Execution and Runtime Isolation Layer**.

Rather than treating these platforms as mutually exclusive alternatives, this POC seeks to define a complementary blueprint that prevents features from overlapping and instead optimizes their respective strengths:

### Division of Responsibilities

```
 ┌─────────────────────────────────────────────────────────┐
 │                   TRUEFOUNDRY LAYER                     │
 │  • Central Catalog  • Model Serving  • Cost Tracking    │
 └───────────────────────────┬─────────────────────────────┘
                             │ (Discovery / Specs)
                             ▼
 ┌─────────────────────────────────────────────────────────┐
 │                  AWS AGENTCORE LAYER                    │
 │  • MicroVM Runtime  • Tool Gateway   • Policy / Memory  │
 └─────────────────────────────────────────────────────────┘

```

* **TrueFoundry (The Control and Governance Plane):** Responsible for global model hosting (vLLM/Triton), central registry/catalog management for models and agents, cross-team tenant cost-enforcement/reporting, and multi-cloud consistency.
* **AWS AgentCore (The Execution and Perimeter Plane):** Responsible for hosting the live, stateful agent execution loop inside serverless MicroVM sandboxes, enforcing zero-trust data boundaries (Cedar policies), managing long-running state/memory, and serving as the direct tool gateway to internal APIs.

---

## 2. POC Use Cases

### Use Case 1: Agent Discovery & Registration Catalog

* **Description:** Evaluate how developers publish, document, and discover production-ready agents across multiple lines of business.
* **TrueFoundry’s Role:** Acts as the **Enterprise Agent Catalog** (the "App Store"). TrueFoundry hosts the descriptive metadata, Agent Cards, and schemas defining what each agent does, what tools it requires, and who owns it.
* **AgentCore’s Role:** Acts as the **Deployment Target**. When an agent is selected from the TrueFoundry catalog, its underlying framework code (e.g., LangGraph, Strands) runs on AgentCore Runtime infrastructure.

### Use Case 2: Protocol Support & Interoperability

* **Description:** Validate cross-agent communication protocols and tool-calling interfaces.
* **TrueFoundry’s Role:** Proxies and intercepts standardized OpenAPI schemas and Model Context Protocol (MCP) definitions for models hosted inside the corporate virtual private cloud (VPC).
* **AgentCore’s Role:** Utilizes the **AgentCore Gateway** to transform existing internal REST APIs or AWS Lambda functions into MCP-compatible tools, natively handling Agent-to-Agent (A2A) protocol calls over JSON-RPC 2.0.

### Use Case 3: Cost Management (Enforcement & Reporting)

* **Description:** Measure, audit, and allocate total cost of ownership (TCO) across multiple business units.
* **TrueFoundry’s Role:** Serves as the central financial clearinghouse. It enforces hard and soft token/dollar budgets per virtual API key or developer team, generating cross-provider analytics graphs.
* **AgentCore’s Role:** Tracks execution runtime metrics (compute hours of the serverless MicroVM sandboxes) and pushes standard OpenTelemetry (OTel) cost/usage dimensions to the central logging repository.

### Use Case 4: Automated Testing & Evaluation (Add-on)

* **Description:** Test agent updates against regression datasets before promoting them to production.
* **TrueFoundry’s Role:** Manages the LLM-as-a-judge infrastructure and gold-standard evaluation datasets.
* **AgentCore’s Role:** Runs the live target agent via the AgentCore Evaluation engine, logging raw output traces for TrueFoundry to score.

---

## 3. High-Level Activities & RACI Matrix

| Phase / Activity | Security Team (PHI/PII) | Identity Team | Platform Team | AI / Engineering Team | Business Unit (BU) |
| --- | --- | --- | --- | --- | --- |
| **1. Infra Setup & VPC Peering** | A | I | R | C | I |
| **2. IAM to TrueFoundry OIDC Mapping** | C | R | R | I | I |
| **3. Agent Catalog Onboarding** | I | I | C | R | A |
| **4. Guardrail Configuration (PHI/PII)** | R | I | C | C | A |
| **5. Core Cost Allocation Policies** | I | I | R | C | A |
| **6. End-to-End POC Execution** | I | I | I | R | C |

> **R:** Responsible | **A:** Accountable | **C:** Consulted | **I:** Informed

---

## 4. Proposed POC Timeline

```
 Weeks:   0     1     2     3     4     5     6
          ├─────┼─────┼─────┼─────┼─────┼─────┤
 Phase 1: [==] Infrastructure & Identity Setup
 Phase 2:       [==] Catalog Integration & Protocol Setup
 Phase 3:             [==] Security Guardrails & Governance
 Phase 4:                   [==] Scenario Run & Validation

```

* **Weeks 1–2: Phase 1 – Infrastructure & Identity Setup**
* Establish secure AWS VPC networking endpoints between TrueFoundry's EKS cluster control plane and serverless AWS AgentCore components.
* Integrate corporate Identity Provider (IdP) across TrueFoundry RBAC and Amazon Cognito/AgentCore Identity.


* **Weeks 3–4: Phase 2 – Catalog Integration & Protocol Setup**
* Register the initial agent prototypes inside TrueFoundry’s Central Catalog.
* Implement AgentCore Gateway configurations to expose backend database APIs over MCP.


* **Weeks 4–5: Phase 3 – Security Guardrails & Governance**
* Deploy inline PII masking via TrueFoundry’s proxy and implement Cedar fine-grained access policies inside AgentCore.
* Configure multi-tenant tenant budget caps in TrueFoundry.


* **Week 6: Phase 4 – Scenario Run, Evaluation, and Validation**
* Execute end-to-end multi-agent workflow testing.
* Compile telemetry and evaluate against Success Criteria.



---

## 5. Success Criteria

* **Successful Catalog Execution:** Developers can discover an agent configuration inside TrueFoundry, initiate it, and have the actual application logic execute reliably within an isolated AgentCore Runtime MicroVM session.
* **Zero-Leak Guardrails:** Simulated payloads containing test PII/PHI are blocked or redacted at the platform perimeter (TrueFoundry AI Gateway or AgentCore Policy layer) before hitting external endpoints.
* **Budget Attribution Accuracy:** 100% of LLM token spend and compute costs generated during the POC are attributed back to the initiating Business Unit's virtual key within TrueFoundry's reporting dashboards.
* **Interop Protocol Latency:** The end-to-end multi-agent round trip (utilizing A2A or MCP routing through AgentCore Gateway and TrueFoundry) introduces less than **150ms** of non-model architectural overhead.

---

## 6. Assumptions

### AWS AgentCore

* The POC will use the recommended **AgentCore CLI (`@aws/agentcore`)** for scaffolding and deployment configurations.
* AgentCore will natively manage long-running state management and session persistence using its built-in serverless filesystem mechanisms.

### Tools & Data Architecture

* Grounding tools will utilize the **Amazon Bedrock Managed Knowledge Base** via the AgentCore Gateway target adapter.
* Deployed agents will have secure network access to interact with the enterprise data lakehouse infrastructure for retrieval operations without exposing direct database credentials.

### Environments

* All POC activities will be conducted in a dedicated, isolated **AWS Sandbox/Non-Prod environment**.
* No production data or real client data will be routed through the platform components during this assessment phase.

### Sandboxing

* Dynamic code execution tasks assigned to the agent will run within AgentCore's built-in **Code Interpreter** container sandbox environment.
* Network traffic generated by the agent during runtime will be strictly constrained via specific AgentCore VPC condition keys and security group boundaries to ensure complete isolation.

---

Would you like to drill down into a specific area, such as mapping out the detailed OIDC token exchange sequence between the TrueFoundry Gateway and AgentCore Identity?
