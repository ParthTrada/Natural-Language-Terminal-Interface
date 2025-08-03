# 🔧 Troubleshooting Guide

This guide helps you resolve common issues with the Natural Language Terminal Interface.

## 🚨 Common Issues

### 1. "Command not found: nlcmd"

#### Problem
The `nlcmd` command is not recognized.

#### Solutions

**Check if aliases are configured:**
```bash
# Check if aliases exist
alias | grep nl

# If no aliases found, add them manually
echo 'alias nlcmd="~/nl-cmd.sh"' >> ~/.zshrc
echo 'alias nl="~/nl-terminal.sh"' >> ~/.zshrc
source ~/.zshrc
```

**Check script locations:**
```bash
# Verify scripts exist and are executable
ls -la ~/nl-cmd.sh ~/nl-terminal.sh

# Make scripts executable if needed
chmod +x ~/nl-cmd.sh ~/nl-terminal.sh
```

**Check PATH:**
```bash
# Verify scripts are in PATH
which nlcmd
which nl

# If not found, check your ~/.zshrc
cat ~/.zshrc | grep nl
```

### 2. "Ollama is not running"

#### Problem
Ollama service is not started or not responding.

#### Solutions

**Start Ollama service:**
```bash
# Start the service
brew services start ollama

# Check status
brew services list | grep ollama

# Test if Ollama responds
ollama run llama2 "test"
```

**Check Ollama installation:**
```bash
# Verify Ollama is installed
which ollama

# Reinstall if needed
brew install ollama
```

**Check for errors:**
```bash
# Check Ollama logs
brew services info ollama

# Restart Ollama
brew services restart ollama
```

### 3. "Model not found"

#### Problem
The Llama2 model is not downloaded.

#### Solutions

**Download the model:**
```bash
# Download Llama2
ollama pull llama2

# Check available models
ollama list

# Test the model
ollama run llama2 "hello"
```

**Check model status:**
```bash
# List all models
ollama list

# Remove and reinstall if corrupted
ollama rm llama2
ollama pull llama2
```

### 4. "Script permission denied"

#### Problem
Scripts are not executable.

#### Solutions

**Make scripts executable:**
```bash
# Make both scripts executable
chmod +x ~/nl-cmd.sh ~/nl-terminal.sh

# Verify permissions
ls -la ~/nl-cmd.sh ~/nl-terminal.sh
```

**Check file ownership:**
```bash
# Check file ownership
ls -la ~/nl-cmd.sh

# Fix ownership if needed
sudo chown $(whoami) ~/nl-cmd.sh ~/nl-terminal.sh
```

### 5. "AI not understanding requests"

#### Problem
The AI is not generating appropriate commands.

#### Solutions

**Test Ollama directly:**
```bash
# Test basic functionality
ollama run llama2 "convert 'show current directory' to shell command"

# Check if the model is working
ollama run llama2 "what is 2+2?"
```

**Improve your requests:**
```bash
# Be more specific
nlcmd "show me the current working directory"
nlcmd "list all files in this directory"
nlcmd "display the contents of the current folder"

# Instead of vague requests
nlcmd "show directory"
nlcmd "list files"
```

**Check system prompt:**
```bash
# Verify the script has the correct system prompt
head -20 ~/nl-cmd.sh
```

### 6. "Command execution fails"

#### Problem
Commands are generated but fail to execute.

#### Solutions

**Test commands manually:**
```bash
# Try the command manually to see the error
pwd
ls -la
df -h
```

**Check command syntax:**
```bash
# Look at the generated command
echo "Generated command: $command"

# Test with bash -n for syntax checking
bash -n -c "$command"
```

**Common macOS issues:**
```bash
# Some commands might need sudo
sudo nlcmd "check system logs"

# Some commands might be different on macOS
nlcmd "check memory usage"  # Uses vm_stat instead of free
```

## 🔍 Debugging Steps

### 1. Enable Debug Mode

**Add debug output to scripts:**
```bash
# Edit nl-cmd.sh and add these lines before command execution
echo "DEBUG: User request: $prompt"
echo "DEBUG: AI response: $command"
echo "DEBUG: Command length: ${#command}"
```

**Test with verbose output:**
```bash
# Run with debug information
bash -x ~/nl-cmd.sh "show current directory"
```

### 2. Check System Status

**Create a diagnostic script:**
```bash
# Create nl-debug.sh
cat > ~/nl-debug.sh << 'EOF'
#!/bin/bash
echo "=== Natural Language Terminal Debug ==="
echo ""
echo "1. System Information:"
echo "   OS: $(uname -s)"
echo "   Version: $(sw_vers -productVersion)"
echo "   Architecture: $(uname -m)"
echo ""
echo "2. Ollama Status:"
echo "   Installed: $(which ollama)"
echo "   Running: $(brew services list | grep ollama)"
echo "   Models: $(ollama list)"
echo ""
echo "3. Script Status:"
echo "   nl-cmd.sh exists: $([ -f ~/nl-cmd.sh ] && echo "Yes" || echo "No")"
echo "   nl-terminal.sh exists: $([ -f ~/nl-terminal.sh ] && echo "Yes" || echo "No")"
echo "   nl-cmd.sh executable: $([ -x ~/nl-cmd.sh ] && echo "Yes" || echo "No")"
echo "   nl-terminal.sh executable: $([ -x ~/nl-terminal.sh ] && echo "Yes" || echo "No")"
echo ""
echo "4. Alias Status:"
echo "   nlcmd alias: $(alias nlcmd 2>/dev/null || echo "Not found")"
echo "   nl alias: $(alias nl 2>/dev/null || echo "Not found")"
echo ""
echo "5. Test Ollama:"
ollama run llama2 "test" 2>/dev/null && echo "   Ollama working: Yes" || echo "   Ollama working: No"
echo ""
echo "6. Test Scripts:"
nlcmd "show current directory" 2>/dev/null && echo "   nlcmd working: Yes" || echo "   nlcmd working: No"
EOF

chmod +x ~/nl-debug.sh
```

**Run diagnostics:**
```bash
./nl-debug.sh
```

### 3. Common Error Messages

#### "Permission denied"
```bash
# Fix permissions
chmod +x ~/nl-cmd.sh ~/nl-terminal.sh
```

#### "No such file or directory"
```bash
# Check if scripts exist
ls -la ~/nl-cmd.sh ~/nl-terminal.sh

# Recreate if missing
# Copy the scripts from the documentation
```

#### "Command not found"
```bash
# Check PATH
echo $PATH

# Add scripts to PATH
export PATH="$HOME:$PATH"
```

#### "Connection refused"
```bash
# Ollama not running
brew services start ollama
```

## 🛠️ Advanced Troubleshooting

### 1. Performance Issues

**Slow response times:**
```bash
# Use smaller model for speed
ollama pull llama2:7b
# Edit scripts to use llama2:7b instead of llama2
```

**High memory usage:**
```bash
# Check Ollama memory usage
ps aux | grep ollama

# Restart Ollama to free memory
brew services restart ollama
```

### 2. Model Issues

**Model not responding:**
```bash
# Remove and reinstall model
ollama rm llama2
ollama pull llama2

# Try alternative model
ollama pull mistral
# Edit scripts to use mistral
```

**Poor command generation:**
```bash
# Try different model
ollama pull codellama
# Edit scripts to use codellama for coding tasks
```

### 3. Script Issues

**Script not working:**
```bash
# Check script syntax
bash -n ~/nl-cmd.sh

# Check for hidden characters
cat -A ~/nl-cmd.sh

# Recreate script from documentation
```

**Alias conflicts:**
```bash
# Check for conflicting aliases
alias | grep nl

# Remove conflicting aliases
unalias nl 2>/dev/null
unalias nlcmd 2>/dev/null
```

## 🔧 Quick Fixes

### 1. Complete Reset

**Reset everything:**
```bash
# Stop Ollama
brew services stop ollama

# Remove scripts
rm ~/nl-cmd.sh ~/nl-terminal.sh

# Remove aliases from ~/.zshrc
sed -i '' '/alias nl=/d' ~/.zshrc
sed -i '' '/alias nlcmd=/d' ~/.zshrc

# Restart fresh
brew services start ollama
ollama pull llama2
# Reinstall scripts and aliases
```

### 2. Alternative Installation

**Use installation script:**
```bash
# Run the automated installation
./install.sh
```

**Manual installation:**
```bash
# Install dependencies
brew install ollama
brew services start ollama
ollama pull llama2

# Create scripts manually
# Copy scripts from documentation
chmod +x ~/nl-cmd.sh ~/nl-terminal.sh

# Add aliases
echo 'alias nlcmd="~/nl-cmd.sh"' >> ~/.zshrc
echo 'alias nl="~/nl-terminal.sh"' >> ~/.zshrc
source ~/.zshrc
```

## 📞 Getting Help

### 1. Self-Diagnosis

**Run the debug script:**
```bash
./nl-debug.sh
```

**Check logs:**
```bash
# Ollama logs
brew services info ollama

# System logs
log show --predicate 'process == "ollama"' --last 1h
```

### 2. Community Support

**GitHub Issues:**
- Create an issue with the debug output
- Include your macOS version
- Include the exact error message

**Common Information to Include:**
```bash
# System information
uname -a
sw_vers

# Ollama information
ollama --version
ollama list

# Script information
ls -la ~/nl-cmd.sh ~/nl-terminal.sh
cat ~/.zshrc | grep nl
```

### 3. Workarounds

**Use direct Ollama commands:**
```bash
# Instead of nlcmd, use Ollama directly
ollama run llama2 "convert 'show current directory' to shell command"
```

**Use alternative models:**
```bash
# Try different models
ollama run mistral "your request"
ollama run codellama "your request"
```

## 🎯 Prevention Tips

### 1. Regular Maintenance

**Update regularly:**
```bash
# Update Homebrew
brew update && brew upgrade

# Update Ollama
brew upgrade ollama

# Update models
ollama pull llama2
```

**Monitor system resources:**
```bash
# Check disk space
df -h

# Check memory usage
vm_stat

# Check Ollama processes
ps aux | grep ollama
```

### 2. Backup Configuration

**Backup your setup:**
```bash
# Backup scripts
cp ~/nl-cmd.sh ~/nl-cmd.sh.backup
cp ~/nl-terminal.sh ~/nl-terminal.sh.backup

# Backup aliases
grep -E "alias nl" ~/.zshrc > ~/nl-aliases.backup
```

**Restore from backup:**
```bash
# Restore scripts
cp ~/nl-cmd.sh.backup ~/nl-cmd.sh
cp ~/nl-terminal.sh.backup ~/nl-terminal.sh

# Restore aliases
cat ~/nl-aliases.backup >> ~/.zshrc
source ~/.zshrc
```

---

**Most issues can be resolved with these troubleshooting steps. If problems persist, check the GitHub repository for updates and community solutions! 🚀**
