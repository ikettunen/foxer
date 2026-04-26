# OpenClaw + Llama Setup Guide for Ubuntu

Setup instructions for deploying OpenClaw multi-agent system with local Llama models on a headless Ubuntu server.

## Prerequisites

- Ubuntu 20.04+ (server or headless)
- 8GB+ RAM (for local models)
- 20GB+ free disk space
- Network access (SSH or direct)
- Git installed

---

## Part 1: Install Ollama (Local LLM Provider)

### 1.1 Download & Install
```bash
# Download Ollama installer
curl -fsSL https://ollama.ai/install.sh | sh

# Start Ollama service
sudo systemctl start ollama
sudo systemctl enable ollama  # Auto-start on boot
```

### 1.2 Verify Installation
```bash
ollama --version
# Should print version info

# Check service status
sudo systemctl status ollama
```

### 1.3 Pull Models
```bash
# Pull Mistral (fastest, cheapest - ~4GB)
ollama pull mistral

# Pull Neural Chat (better quality - ~4GB)
ollama pull neural-chat

# Pull Codellama (code-specific - ~4GB)
ollama pull codellama

# List available models
ollama list
```

### 1.4 Verify Models Work
```bash
# Test Mistral
ollama run mistral "Hello, what is your name?"

# Should respond and show tokens/sec
# Press Ctrl+D to exit
```

---

## Part 2: Install OpenClaw

### 2.1 Install PowerShell on Ubuntu
```bash
# Add Microsoft repository
sudo apt-get update
sudo apt-get install -y wget apt-transport-https software-properties-common

# Add PowerShell repository
wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Install PowerShell
sudo apt-get update
sudo apt-get install -y powershell

# Verify
pwsh --version
```

### 2.2 Clone/Download OpenClaw Repository
```bash
cd ~
git clone https://github.com/ikettunen/foxer.git
cd foxer

# Or if SSH key setup:
git clone git@github.com:ikettunen/foxer.git
```

### 2.3 Copy Configuration Files
```bash
# Create OpenClaw directory
mkdir -p ~/.openclaw/agents/{main,claw,pilot,claudex,gemcourse}/{agent,sessions}

# Copy model configuration
cp openclaw-models.ps1 ~/.openclaw/

# Copy OpenClaw main script (if in repo)
cp openclaw.ps1 ~/.openclaw/
```

### 2.4 Create openclaw.json Config
```bash
cat > ~/.openclaw/openclaw.json << 'EOF'
{
  "agents": {
    "main": {
      "model": "ollama:mistral",
      "endpoint": "http://localhost:11434"
    },
    "claw": {
      "model": "ollama:neural-chat",
      "endpoint": "http://localhost:11434"
    },
    "pilot": {
      "model": "ollama:mistral",
      "endpoint": "http://localhost:11434"
    },
    "claudex": {
      "model": "ollama:neural-chat",
      "endpoint": "http://localhost:11434"
    },
    "gemcourse": {
      "model": "ollama:mistral",
      "endpoint": "http://localhost:11434"
    }
  },
  "ollama": {
    "enabled": true,
    "baseUrl": "http://localhost:11434",
    "timeout": 300
  },
  "whatsapp": {
    "enabled": false,
    "webhookPort": 3000
  }
}
EOF

# Verify
cat ~/.openclaw/openclaw.json
```

---

## Part 3: Verify Everything Works

### 3.1 Start Ollama (if not running)
```bash
# Check if running
sudo systemctl status ollama

# If not, start it
sudo systemctl start ollama
```

### 3.2 Test Model Directly
```bash
# Quick test
curl http://localhost:11434/api/generate -d '{"model":"mistral","prompt":"What is 2+2?"}' | head -20

# Should return JSON with response
```

### 3.3 Test OpenClaw with PowerShell
```bash
# Start PowerShell
pwsh

# Load the models module
. ~/.openclaw/openclaw-models.ps1

# Test agent lookup
Get-AgentModel -AgentId "pilot"

# Should return: ollama:mistral
```

---

## Part 4: Remote Access Setup (No Keyboard/Screen)

### 4.1 Enable SSH (if not already)
```bash
sudo apt-get install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# Get IP address
hostname -I
```

### 4.2 Connect from Your Main Computer
```bash
# From your main machine
ssh user@ubuntu-ip-address

# Example:
ssh ubuntu@192.168.1.100
```

### 4.3 Create Headless Runner Script
```bash
# Create systemd service for OpenClaw
sudo cat > /etc/systemd/system/openclaw.service << 'EOF'
[Unit]
Description=OpenClaw Multi-Agent System
After=network.target ollama.service
Wants=ollama.service

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/.openclaw
ExecStart=/usr/bin/pwsh -Command "& { . ./openclaw-models.ps1; Write-Host 'OpenClaw loaded' }"
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable service
sudo systemctl daemon-reload
sudo systemctl enable openclaw
sudo systemctl start openclaw

# Check status
sudo systemctl status openclaw
```

---

## Part 5: Usage on Ubuntu

### 5.1 SSH into Ubuntu Machine
```bash
ssh user@ubuntu-ip
```

### 5.2 Load OpenClaw & Check Stats
```bash
pwsh

# Load models
. ~/.openclaw/openclaw-models.ps1

# View all agent configs
foreach ($agent in @("main", "claw", "pilot", "claudex", "gemcourse")) {
    Get-AgentModelStats -AgentId $agent
}
```

### 5.3 Test an Agent Query
```pwsh
# Test pilot agent with Mistral model
Invoke-AgentWithFallback -AgentId "pilot" -Message "Create a simple test function"

# Should process through Ollama and return response
```

---

## Part 6: Performance Tuning

### 6.1 Ollama Settings
```bash
# Set context window for models
export OLLAMA_NUM_THREAD=4  # Adjust based on CPU cores
export OLLAMA_NUM_CTX=2048   # Context length (more = slower)

# Persist settings
echo 'export OLLAMA_NUM_THREAD=4' >> ~/.bashrc
echo 'export OLLAMA_NUM_CTX=2048' >> ~/.bashrc
```

### 6.2 Monitor Resource Usage
```bash
# Watch Ollama memory/CPU
watch -n 1 'ps aux | grep ollama'

# Check disk space
df -h

# Monitor RAM
free -h
```

---

## Part 7: Troubleshooting

### Issue: "Connection refused on localhost:11434"
```bash
# Ollama not running
sudo systemctl restart ollama

# Check logs
sudo journalctl -u ollama -n 20
```

### Issue: PowerShell module not loading
```bash
# Verify file exists
ls -la ~/.openclaw/openclaw-models.ps1

# Test PowerShell syntax
pwsh -c ". ~/.openclaw/openclaw-models.ps1; Get-AgentModel -AgentId pilot"
```

### Issue: Out of Memory
```bash
# Check available RAM
free -h

# Reduce model context window
export OLLAMA_NUM_CTX=1024

# Use smaller models temporarily
ollama pull mistral:7b-q4_0  # Quantized version (~2GB)
```

---

## Quick Start Summary

**From scratch on Ubuntu:**
```bash
# 1. Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# 2. Pull models
ollama pull mistral
ollama pull neural-chat

# 3. Clone repo
git clone https://github.com/ikettunen/foxer.git
cd foxer

# 4. Setup OpenClaw dirs
mkdir -p ~/.openclaw/agents/{main,claw,pilot,claudex,gemcourse}/{agent,sessions}
cp openclaw-models.ps1 ~/.openclaw/

# 5. Test with PowerShell
pwsh
. ~/.openclaw/openclaw-models.ps1
Get-AgentModel -AgentId "pilot"
```

---

## API Keys (Optional - for hybrid mode)

If you want to keep premium models as fallback while using local Ollama:

```bash
# Set environment variables for API keys
export OPENAI_API_KEY="sk-your-key"
export ANTHROPIC_API_KEY="sk-ant-your-key"
export MISTRAL_API_KEY="your-key"

# Persist in ~/.bashrc
echo 'export OPENAI_API_KEY="sk-your-key"' >> ~/.bashrc
source ~/.bashrc
```

Then update `~/.openclaw/openclaw.json` to include API endpoints.

---

## Keyboard & Screen Setup

Once keyboard/screen arrive:
1. Plug in directly to Ubuntu machine
2. Or continue using SSH from main computer
3. GUI is optional - everything works via CLI/SSH

**Recommended**: Keep it headless, access via SSH from your main computer. Much cleaner setup!

---

## Next Steps

1. ✅ Install Ollama + models
2. ✅ Setup PowerShell & OpenClaw
3. ✅ Test agents via SSH
4. 📝 Configure WhatsApp routing (separate guide)
5. 📊 Monitor usage & costs

Questions? Check logs with: `sudo journalctl -u ollama -f`
