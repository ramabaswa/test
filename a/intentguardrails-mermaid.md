sequenceDiagram
    autonumber
    actor Dev as Platform / AI Developer
    participant SN as ServiceNow<br/>(System of Record & CMDB)
    participant AF as Azure AI Foundry<br/>(Content Safety & Intent Guardrails)
    participant Reg as Solo.io agentregistry<br/>(Secure Catalog)
    participant KAgent as Solo.io kagent<br/>(Kubernetes Agentic Runtime)
    participant AGW as Solo.io agentgateway<br/>(MCP / LLM Proxy)

    Note over Dev, SN: Phase 1: Registration & Skill Declaration
    Dev->>SN: Submit Onboarding Request<br/>(Agent Profile, NHI Metadata, Declared MCP Skills)
    
    Note over SN, AF: Phase 2: Intent Validation & Content Safety
    SN->>AF: Trigger Evaluation Pipeline<br/>(Analyze Declared Prompt Templates & System Instructions)
    activate AF
    AF->>AF: Content Safety Audit<br/>(Check for Jailbreaks, Indirect Injection, Toxicity)
    AF->>AF: Intent Guardrail Matching<br/>(Map skills against authorized business domain boundaries)
    AF-->>SN: Return Audit Attestation & Approved Skill Manifest
    deactivate AF

    Note over SN, Reg: Phase 3: Cryptographic Identity & Cataloging
    SN->>SN: Generate Non-Human Identity (NHI)<br/>(Issue SPIFFE/X.509 Cryptographic Cert)
    SN->>Reg: Publish Validated Agent Artifacts<br/>(NHI Cryptographic Cert, Approved MCP Servers, Metadata)
    
    Note over Reg, AGW: Phase 4: Runtime Enforcement
    KAgent->>Reg: Sync Approved Configuration<br/>(Pull Signed Manifest for Target Workload)
    KAgent->>KAgent: Extend Kubernetes Namespace<br/>(Inject NHI Identity, Apply Runtime Sandboxing Policies)
    
    Note over Dev, AGW: Phase 5: Live Execution Path
    Dev->>AGW: Runtime Request via AI Agent
    AGW->>AGW: Enforce Token-Weighted Rate Limiting &<br/>MCP Server Provenance Checks
    AGW-->>Dev: Authorized & Guardrailed Response
