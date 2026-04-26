# OpenClaw Multi-Model Configuration
# Each agent can use different models with fallback chains

$script:AgentModels = @{
    "main" = @{
        primary = "openai:gpt-4-turbo"
        fallback = @("anthropic:claude-3-sonnet", "mistral:mistral-medium", "ollama:local")
        apiKey = $env:OPENAI_API_KEY
    }
    
    "claw" = @{
        primary = "anthropic:claude-3-opus"  # Best for code review
        fallback = @("openai:gpt-4", "mistral:mistral-large", "ollama:neural-chat")
        apiKey = $env:ANTHROPIC_API_KEY
    }
    
    "pilot" = @{
        primary = "openai:gpt-4"  # Fast, good for implementation
        fallback = @("anthropic:claude-3-sonnet", "mistral:mistral-medium", "ollama:codellama")
        apiKey = $env:OPENAI_API_KEY
    }
    
    "claudex" = @{
        primary = "anthropic:claude-3-sonnet"  # Good for creative writing
        fallback = @("mistral:mistral-medium", "openai:gpt-4", "ollama:neural-chat")
        apiKey = $env:ANTHROPIC_API_KEY
    }
    
    "gemcourse" = @{
        primary = "mistral:mistral-large"  # Cost-effective for structured content
        fallback = @("anthropic:claude-3-sonnet", "openai:gpt-4", "ollama:neural-chat")
        apiKey = $env:MISTRAL_API_KEY
    }
}

# API Provider Endpoints
$script:APIEndpoints = @{
    "openai" = "https://api.openai.com/v1/chat/completions"
    "anthropic" = "https://api.anthropic.com/v1/messages"
    "mistral" = "https://api.mistral.ai/v1/chat/completions"
    "ollama" = "http://localhost:11434/api/chat"
}

# Pricing per 1K tokens (for cost tracking)
$script:ModelPricing = @{
    "openai:gpt-4" = @{ input = 0.03; output = 0.06 }
    "openai:gpt-4-turbo" = @{ input = 0.01; output = 0.03 }
    "anthropic:claude-3-opus" = @{ input = 0.015; output = 0.075 }
    "anthropic:claude-3-sonnet" = @{ input = 0.003; output = 0.015 }
    "mistral:mistral-large" = @{ input = 0.0008; output = 0.0024 }
    "mistral:mistral-medium" = @{ input = 0.00027; output = 0.00081 }
    "ollama:local" = @{ input = 0; output = 0 }  # Free, self-hosted
}

function Get-AgentModel {
    param(
        [string]$AgentId,
        [string]$Fallback = $null
    )
    
    if (-not $script:AgentModels.ContainsKey($AgentId)) {
        throw "Unknown agent: $AgentId"
    }
    
    if ($Fallback) {
        $model = $script:AgentModels[$AgentId].fallback -match $Fallback
        if ($model) { return $model[0] }
        throw "Fallback model not found for agent $AgentId"
    }
    
    return $script:AgentModels[$AgentId].primary
}

function Switch-AgentModel {
    param(
        [string]$AgentId,
        [string]$NewModel
    )
    
    if (-not $script:AgentModels.ContainsKey($AgentId)) {
        throw "Unknown agent: $AgentId"
    }
    
    $script:AgentModels[$AgentId].primary = $NewModel
    Write-Host "✓ Agent '$AgentId' switched to: $NewModel"
}

function Get-ModelProvider {
    param([string]$Model)
    
    $provider = $Model.Split(':')[0]
    return $provider
}

function Invoke-AgentWithFallback {
    param(
        [string]$AgentId,
        [string]$Message,
        [int]$MaxRetries = 3
    )
    
    $config = $script:AgentModels[$AgentId]
    $models = @($config.primary) + $config.fallback
    
    foreach ($model in $models) {
        try {
            Write-Host "Attempting: $AgentId → $model"
            
            $provider = Get-ModelProvider $model
            $endpoint = $script:APIEndpoints[$provider]
            
            # Call the model (implementation depends on provider)
            # This is a placeholder for actual API calls
            Write-Host "✓ Success with $model"
            return $model
        }
        catch {
            Write-Warning "Failed with $model: $($_.Exception.Message)"
            continue
        }
    }
    
    throw "All models exhausted for agent: $AgentId"
}

function Get-AgentModelStats {
    param([string]$AgentId)
    
    $config = $script:AgentModels[$AgentId]
    
    Write-Host "Agent: $AgentId"
    Write-Host "  Primary: $($config.primary)"
    Write-Host "  Fallbacks: $($config.fallback -join ', ')"
    
    $primary_price = $script:ModelPricing[$config.primary]
    if ($primary_price) {
        Write-Host "  Cost: $($primary_price.input) per 1K input, $($primary_price.output) per 1K output"
    }
}

# Export functions
Export-ModuleMember -Function @(
    'Get-AgentModel',
    'Switch-AgentModel', 
    'Get-ModelProvider',
    'Invoke-AgentWithFallback',
    'Get-AgentModelStats'
)
