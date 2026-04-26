# OpenClaw Multi-Model Management

## Overview
Each agent can use a different AI model with automatic fallback chains when tokens run out or API fails.

## Agent Model Configuration

| Agent | Primary | Fallback 1 | Fallback 2 | Best For |
|-------|---------|-----------|-----------|----------|
| **main** | GPT-4 Turbo | Claude 3 Sonnet | Mistral Medium | General routing |
| **claw** | Claude 3 Opus | GPT-4 | Mistral Large | Code review (needs deep reasoning) |
| **pilot** | GPT-4 | Claude 3 Sonnet | Mistral Medium | Implementation (speed matters) |
| **claudex** | Claude 3 Sonnet | Mistral Medium | GPT-4 | Marketing copy (creative) |
| **gemcourse** | Mistral Large | Claude 3 Sonnet | GPT-4 | Course writing (cost-effective) |

## Usage

### 1. Get Current Agent Model
```powershell
. .\openclaw-models.ps1
Get-AgentModel -AgentId "pilot"
# Returns: openai:gpt-4
```

### 2. Switch Agent to Different Model
```powershell
Switch-AgentModel -AgentId "pilot" -NewModel "anthropic:claude-3-sonnet"
# Output: ✓ Agent 'pilot' switched to: anthropic:claude-3-sonnet
```

### 3. View Agent Stats & Pricing
```powershell
Get-AgentModelStats -AgentId "claw"
# Output:
# Agent: claw
#   Primary: anthropic:claude-3-opus
#   Fallbacks: openai:gpt-4, mistral:mistral-large, ollama:neural-chat
#   Cost: 0.015 per 1K input, 0.075 per 1K output
```

### 4. Invoke Agent With Automatic Fallback
```powershell
Invoke-AgentWithFallback -AgentId "pilot" -Message "Implement feature X"
# Automatically tries: GPT-4 → Claude Sonnet → Mistral Medium → Ollama
```

---

## Model Pricing Comparison

### Cost per 1M tokens:
- **OpenAI GPT-4**: $30 (input) + $60 (output) = **$90/M**
- **OpenAI GPT-4 Turbo**: $10 (input) + $30 (output) = **$40/M** ✓ Best price/quality
- **Anthropic Claude 3 Opus**: $15 (input) + $75 (output) = **$90/M**
- **Anthropic Claude 3 Sonnet**: $3 (input) + $15 (output) = **$18/M** ✓ Great balance
- **Mistral Large**: $0.8 (input) + $2.4 (output) = **$3.2/M** ✓ Cheapest quality
- **Ollama (Local)**: **$0/M** ✓ Free but requires setup

---

## Recommended Strategies

### Strategy 1: Balance Cost & Quality (default)
```
claw → Claude Opus (best review) → GPT-4 (backup)
pilot → GPT-4 (fast) → Claude Sonnet (cost backup)
claudex → Claude Sonnet (creative) → Mistral (cheap backup)
gemcourse → Mistral (cost) → Claude Sonnet (quality backup)
```

### Strategy 2: Maximum Cost Reduction
Switch all agents to Mistral as primary, use Claude/GPT as fallback:
```powershell
foreach ($agent in @("pilot", "claw", "claudex", "gemcourse")) {
    Switch-AgentModel -AgentId $agent -NewModel "mistral:mistral-large"
}
# Expected savings: 60-70% reduction in API costs
```

### Strategy 3: Free Self-Hosted (Ollama)
Use local Ollama for all agents when offline:
```powershell
foreach ($agent in @("pilot", "claw", "claudex")) {
    Switch-AgentModel -AgentId $agent -NewModel "ollama:neural-chat"
}
# Cost: $0 (runs locally - requires ~8GB RAM)
```

---

## Token Management

### When to Switch Models:
1. **Out of Tokens**: Automatically falls back to next model
2. **Cost Too High**: Manually switch to cheaper model
3. **Quality Issues**: Temporarily upgrade to premium model
4. **Rate Limited**: Rotate models to distribute load

### Example: Rotating on Rate Limit
```powershell
# If Claude hits rate limit for code review
Switch-AgentModel -AgentId "claw" -NewModel "openai:gpt-4"
Write-Host "Switched claw to GPT-4 (Claude rate limited)"

# Later: switch back
Switch-AgentModel -AgentId "claw" -NewModel "anthropic:claude-3-opus"
```

---

## Setup Instructions

### 1. Set Environment Variables
```powershell
$env:OPENAI_API_KEY = "your-openai-key"
$env:ANTHROPIC_API_KEY = "your-anthropic-key"
$env:MISTRAL_API_KEY = "your-mistral-key"
```

### 2. For Local Ollama (Free Option)
```bash
# Install Ollama from https://ollama.ai
ollama pull neural-chat
ollama pull codellama
ollama pull mistral
# Then models available at localhost:11434
```

### 3. Load Module in OpenClaw
Add to your OpenClaw bootstrap:
```powershell
. .\openclaw-models.ps1
```

---

## Current Token Usage

Track which model each agent is using and remaining quota:

```powershell
# View all agent models
Get-ChildItem (Join-Path $env:USERPROFILE ".openclaw/agents") | 
  foreach { 
    Get-AgentModelStats -AgentId $_.Name 
  }
```

---

## Cost Estimate

**Monthly estimate (10K API calls/month):**
- All Claude: ~$900
- All GPT-4 Turbo: ~$400  
- All Mistral: ~$32 ✓ **96% savings!**
- Hybrid (Mistral + Claude fallback): ~$50

→ **Recommendation**: Use Mistral as primary, keep Claude/GPT as fallback for when quality matters.
