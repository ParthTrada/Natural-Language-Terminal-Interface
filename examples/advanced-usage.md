# 🔧 Advanced Usage Guide

This guide covers advanced features, customization options, and complex usage scenarios for power users.

## 🎛️ Customization

### 1. Modifying System Prompts

You can customize the AI's behavior by editing the system prompts in the scripts.

#### nl-cmd.sh Customization
```bash
# Edit the system_prompt variable in nl-cmd.sh
system_prompt="You are a shell command generator. Convert natural language to shell commands.

RULES:
1. Respond with ONLY the shell command
2. No explanations, no markdown, no quotes
3. Just the raw command

EXAMPLES:
- 'show me the current directory' -> pwd
- 'list all files' -> ls -la
# Add your custom examples here
- 'your custom request' -> your_command

For macOS, use brew for package management."
```

#### nl-terminal.sh Customization
```bash
# Edit the system_prompt variable in nl-terminal.sh
local system_prompt="You are a helpful assistant that converts natural language requests into shell commands. 
IMPORTANT: Respond with ONLY the shell command, nothing else. No explanations, no markdown, just the command.
Examples:
- 'show me the current directory' -> 'pwd'
- 'list all files' -> 'ls -la'
# Add your custom examples here
- 'your custom request' -> 'your_command'

For macOS specific commands, use brew for package management and appropriate macOS utilities."
```

### 2. Using Different Models

#### Install Additional Models
```bash
# Install specialized models
ollama pull codellama    # Better for coding tasks
ollama pull mistral      # Faster, smaller model
ollama pull llama2:7b    # Smaller, faster version
ollama pull llama2:13b   # Larger, more accurate
```

#### Modify Scripts for Different Models
```bash
# In both scripts, change:
ollama run llama2 "your prompt"

# To:
ollama run codellama "your prompt"    # For coding tasks
ollama run mistral "your prompt"      # For faster responses
ollama run llama2:7b "your prompt"    # For speed over accuracy
```

### 3. Custom Aliases

#### Create Specialized Aliases
```bash
# Add to your ~/.zshrc
alias nlcode="~/nl-cmd.sh --model codellama"
alias nlfast="~/nl-cmd.sh --model mistral"
alias nlcodechat="~/nl-terminal.sh --model codellama"
```

#### Environment-Specific Aliases
```bash
# Development aliases
alias nlgit="nlcmd 'git status'"
alias nlpy="nlcmd 'python3 --version'"
alias nlnode="nlcmd 'node --version'"

# System aliases
alias nlsys="nlcmd 'uname -a'"
alias nldisk="nlcmd 'df -h'"
alias nlmem="nlcmd 'vm_stat'"
```

## 🔄 Complex Workflows

### 1. Multi-Step Operations

#### Development Setup
```bash
# Set up a new project
nlcmd "create a new directory called myproject"
nlcmd "go to myproject directory"
nlcmd "initialize a new git repository"
nlcmd "create a new python virtual environment"
nlcmd "activate the virtual environment"
nlcmd "install python packages: flask, requests, pytest"
```

#### System Maintenance
```bash
# System cleanup workflow
nlcmd "check disk space usage"
nlcmd "find large files in my home directory"
nlcmd "show me what's using the most disk space"
nlcmd "update all my packages"
nlcmd "clean up old log files"
nlcmd "check for system updates"
```

### 2. Conditional Operations

#### Smart File Management
```bash
# Check before operations
nlcmd "check if file.txt exists"
nlcmd "if file.txt exists, show me its contents"
nlcmd "if the Downloads folder is full, show me the largest files"
```

#### Git Workflow Automation
```bash
# Smart git operations
nlcmd "check if I have uncommitted changes"
nlcmd "if I have changes, show me what files are modified"
nlcmd "if I have changes, add them and commit with message 'auto commit'"
```

### 3. Data Processing

#### File Analysis
```bash
# Analyze file systems
nlcmd "find all files larger than 100MB"
nlcmd "count how many python files I have"
nlcmd "find duplicate files in my Downloads folder"
nlcmd "show me the most recently modified files"
```

#### Log Analysis
```bash
# Process logs
nlcmd "find all log files in the system"
nlcmd "show me the last 50 lines of system.log"
nlcmd "find error messages in recent logs"
nlcmd "count how many times 'error' appears in log files"
```

## 🛠️ Advanced Scripting

### 1. Custom Command Functions

#### Create Helper Functions
```bash
# Add to your ~/.zshrc
nl_backup() {
    nlcmd "create a backup of $1"
}

nl_search() {
    nlcmd "search for '$1' in all files"
}

nl_clean() {
    nlcmd "clean up temporary files"
}
```

#### Batch Operations
```bash
# Process multiple items
for file in *.txt; do
    nlcmd "process file $file"
done

# Conditional processing
if [ -d "node_modules" ]; then
    nlcmd "clean up node_modules"
fi
```

### 2. Integration with Other Tools

#### Combine with Existing Scripts
```bash
# Use with existing automation
nlcmd "run my backup script"
nlcmd "execute the deployment script"
nlcmd "run the test suite"
```

#### Custom Workflows
```bash
# Development workflow
nlcmd "check out the main branch"
nlcmd "pull latest changes"
nlcmd "create a new feature branch"
nlcmd "run the linter"
nlcmd "run the tests"
```

## 🎯 Performance Optimization

### 1. Model Selection

#### Task-Specific Models
```bash
# For coding tasks
nlcmd "generate a python script for web scraping"

# For system administration
nlcmd "analyze system performance"

# For file operations
nlcmd "organize my Downloads folder"
```

#### Response Time Optimization
```bash
# Use smaller models for speed
ollama run llama2:7b "your request"

# Use larger models for accuracy
ollama run llama2:13b "your request"
```

### 2. Caching Strategies

#### Command History
```bash
# Save frequently used commands
alias nl_pwd="nlcmd 'show me the current directory'"
alias nl_ls="nlcmd 'list all files'"
alias nl_df="nlcmd 'check disk space'"
```

#### Custom Prompts
```bash
# Create reusable prompts
export NL_PROMPT="You are a macOS system administrator. Convert requests to shell commands."
```

### 3. Parallel Processing

#### Multiple Operations
```bash
# Run operations in parallel
nlcmd "check disk space" &
nlcmd "check memory usage" &
nlcmd "check network status" &
wait
```

## 🔍 Advanced Debugging

### 1. Verbose Mode

#### Enable Debug Output
```bash
# Add to scripts for debugging
echo "DEBUG: User request: $prompt"
echo "DEBUG: AI response: $command"
echo "DEBUG: Execution result: $?"
```

#### Custom Debug Functions
```bash
nl_debug() {
    echo "=== DEBUG INFO ==="
    echo "Ollama status: $(brew services list | grep ollama)"
    echo "Available models: $(ollama list)"
    echo "Current directory: $(pwd)"
    echo "Script permissions: $(ls -la ~/nl-cmd.sh)"
}
```

### 2. Error Handling

#### Custom Error Messages
```bash
# Add to scripts
if [[ $? -ne 0 ]]; then
    echo "❌ Command failed with exit code $?"
    echo "💡 Try running the command manually to debug"
fi
```

#### Recovery Strategies
```bash
# Automatic retry
nlcmd "try again with a different approach"
nlcmd "use a simpler command"
nlcmd "check if the prerequisites are met"
```

## 🎨 Customization Examples

### 1. Development Environment

#### Python Development
```bash
# Python-specific aliases
alias nlpy="nlcmd 'python3 --version'"
alias nlvenv="nlcmd 'create a new python virtual environment'"
alias nlreq="nlcmd 'install python package'"
alias nltest="nlcmd 'run python tests'"
```

#### Node.js Development
```bash
# Node.js-specific aliases
alias nlnode="nlcmd 'node --version'"
alias nlnpm="nlcmd 'npm install'"
alias nlrun="nlcmd 'npm start'"
alias nltest="nlcmd 'npm test'"
```

### 2. System Administration

#### macOS Management
```bash
# System management aliases
alias nlsys="nlcmd 'check system information'"
alias nlbrew="nlcmd 'update homebrew packages'"
alias nlclean="nlcmd 'clean up system files'"
alias nlbackup="nlcmd 'create system backup'"
```

#### Network Management
```bash
# Network aliases
alias nlnet="nlcmd 'check network status'"
alias nlping="nlcmd 'test network connectivity'"
alias nlport="nlcmd 'check open ports'"
alias nlip="nlcmd 'show IP address'"
```

## 🚀 Power User Tips

### 1. Keyboard Shortcuts

#### Custom Key Bindings
```bash
# Add to your ~/.zshrc
bindkey '^[n' 'nlcmd "show me the current directory"\n'
bindkey '^[l' 'nlcmd "list all files"\n'
bindkey '^[s' 'nlcmd "check disk space"\n'
```

### 2. Integration with IDEs

#### VS Code Integration
```bash
# Add to VS Code settings
{
    "terminal.integrated.shellArgs.osx": ["-c", "source ~/.zshrc"]
}
```

#### Custom Commands
```bash
# IDE-specific commands
nlcmd "open current project in VS Code"
nlcmd "run the current file"
nlcmd "debug the current application"
```

### 3. Automation Scripts

#### Scheduled Tasks
```bash
# Add to crontab
0 9 * * * nlcmd "check system health"
0 18 * * * nlcmd "create daily backup"
```

#### Event-Driven Automation
```bash
# Monitor file changes
fswatch -o . | xargs -n1 -I{} nlcmd "process new files"
```

## 🎯 Best Practices

### 1. Command Organization
- Group related commands together
- Use consistent naming conventions
- Document complex workflows
- Test commands before automation

### 2. Error Prevention
- Always preview commands before execution
- Use safe defaults for dangerous operations
- Implement proper error handling
- Keep backups of important data

### 3. Performance Monitoring
- Monitor response times
- Track command success rates
- Optimize frequently used operations
- Cache common results

---

**Master these advanced features to unlock the full potential of your Natural Language Terminal Interface! 🚀**
