sequenceDiagram
    autonumber
    actor Human as Human identity<br/>Employee / customer / administrator
    participant Client as Client application identity<br/>Web app / backend / Copilot host
    participant Entra as Microsoft Entra ID
    participant APIM as API Management / Agent API
    participant Agent as Agent identity<br/>Managed identity / WIF
    participant Gateway as MCP Gateway identity
    participant Tool as Tool / workload identity<br/>CRM, DB, document search
    participant Oasis as Oasis governance identity

    Note over Human,Oasis: Identity and authorization boundaries for a governed agent workflow

    Human->>Client: Initiates business request
    Note right of Human: Human role limits what<br/>business actions may be requested

    Client->>Entra: Authenticate user / obtain client token
    Entra-->>Client: Token with user and application claims

    Client->>APIM: Call agent API with access token
    APIM->>Entra: Validate token, audience, issuer,<br/>application and user claims
    Entra-->>APIM: Token validation result

    APIM->>APIM: Apply API policy, rate limit,<br/>and allowed agent-route checks

    alt Request allowed
        APIM->>Agent: Forward approved request context
        Note over Agent: Agent identity is authorized only for<br/>approved MCP tools and action categories

        Agent->>Gateway: Request approved tool operation
        Gateway->>Entra: Obtain/exchange workload token<br/>for permitted downstream scope
        Entra-->>Gateway: Scoped tool-access token

        Gateway->>Gateway: Enforce MCP policy, tool allow-list,<br/>input constraints, and action authorization

        alt Tool call permitted
            Gateway->>Tool: Invoke narrowly scoped operation
            Note right of Tool: Workload identity has access only to<br/>its designated service or dataset
            Tool-->>Gateway: Return constrained result
            Gateway-->>Agent: Return tool result
            Agent-->>APIM: Produce response / proposed action
            APIM-->>Client: Return authorized response
            Client-->>Human: Present result
        else Tool call denied
            Gateway-->>Agent: Deny tool call and return policy reason
            Agent-->>APIM: Return safe failure / explanation
            APIM-->>Client: Denial response
            Client-->>Human: Explain request cannot be completed
        end

    else Request denied
        APIM-->>Client: Deny request
        Client-->>Human: Explain access is not authorized
    end

    par Governance discovery and monitoring
        Oasis->>APIM: Read configuration, API policies,<br/>identity assignments, and audit metadata
        APIM-->>Oasis: Discovery data
    and
        Oasis->>Gateway: Read tool registrations, permissions,<br/>policy state, and audit metadata
        Gateway-->>Oasis: Discovery data
    and
        Oasis->>Tool: Read workload identity scopes,<br/>resource configuration, and logs
        Tool-->>Oasis: Discovery data
    end

    Oasis->>Oasis: Detect drift, excessive permissions,<br/>or policy violations

    opt Controlled remediation
        Oasis->>Entra: Request tightly scoped, audited<br/>remediation action
        Entra-->>Oasis: Approve or deny controlled write
    end
