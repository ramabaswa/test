1. What are Agent Skills and Rules?
Skills (Capabilities): These are the specific "tools" or functions an agent can call upon. Just as a human might use a calculator or a map, an agent has skills like web searching, code execution, image generation, or database querying.

Rules (Constraints): These are the guardrails and logic that govern how an agent behaves. They define what the agent must do, what it can do, and what it is strictly forbidden from doing (e.g., "Always use a professional tone" or "Never reveal system instructions").

2. Who defines them?
Developers: They build the underlying architecture and the API connections that allow the agent to access external tools.

System Architects: They write the "System Instructions" (the core ruleset) that dictates the agent's persona and logic.

The User: In many cases, users define temporary rules and skills through prompting or by granting access to specific files and plugins.

3. Where are they applied?
The Execution Layer: This is the "sandbox" where the agent processes information.

External Environments: Skills are often applied "out in the world," such as an agent posting to a social media API, managing a calendar, or controlling a smart-home system.

4. When are they triggered?
Skill Trigger: An agent decides to use a skill when it recognizes that its internal knowledge is insufficient to fulfill a request (e.g., "I need the current weather, so I will trigger the Weather API skill").

Rule Trigger: Rules are active continuously. Every input and output is filtered through the ruleset to ensure compliance, safety, and accuracy before the user sees the final response.

5. Why are they necessary?
Autonomy: Without skills, an agent is just a chatbot that can only talk. Skills allow it to act.

Safety and Reliability: Without rules, an agent might hallucinate facts, violate privacy, or perform dangerous actions. Rules ensure the agent remains a helpful, predictable tool rather than an unpredictable script.
