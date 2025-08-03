# 📖 Basic Usage Guide

This guide covers the fundamental usage of the Natural Language Terminal Interface.

## 🚀 Quick Start

### Prerequisites
- macOS with Homebrew installed
- Ollama running with Llama2 model
- Scripts installed and aliases configured

### Installation Check
```bash
# Verify Ollama is running
ollama list

# Check if aliases are available
which nlcmd
which nl
```

## 💬 Single Command Mode

Use `nlcmd` for one-off natural language commands.

### Basic Commands

#### File System Operations
```bash
nlcmd "show me the current directory"
nlcmd "list all files in this directory"
nlcmd "show me what's in the Downloads folder"
nlcmd "create a new directory called test"
nlcmd "delete the file called old.txt"
```

#### System Information
```bash
nlcmd "check disk space"
nlcmd "show running processes"
nlcmd "check system information"
nlcmd "check memory usage"
nlcmd "show network connections"
```

#### Package Management
```bash
nlcmd "install a package called htop"
nlcmd "update my system"
nlcmd "install python package requests"
nlcmd "install node package express"
```

#### Git Operations
```bash
nlcmd "check git status"
nlcmd "commit my changes"
nlcmd "push to remote"
nlcmd "pull from remote"
```

## 🗣️ Interactive Mode

Use `nl` for continuous conversation with your terminal.

### Starting Interactive Mode
```bash
nl
```

### Example Session
```
🤖 Natural Language Terminal Interface
💡 Powered by Ollama + Llama2
📝 Type your request in natural language (or 'quit' to exit)

💬 You: show me the current directory
🤔 Thinking...
🤖 I understood: 'show me the current directory'
📝 Command to execute: pwd

❓ Do you want to execute this command? (y/n): y
🚀 Executing command...
----------------------------------------
/Users/yourname
----------------------------------------
✅ Command completed!

💬 You: list all files
🤔 Thinking...
🤖 I understood: 'list all files'
📝 Command to execute: ls -la

❓ Do you want to execute this command? (y/n): y
🚀 Executing command...
----------------------------------------
total 4616
drwxr-x---+  39 yourname  staff     1248 Aug  3 12:11 .
drwxr-xr-x    5 root        admin      160 Dec  7  2024 ..
...
----------------------------------------
✅ Command completed!

💬 You: quit
👋 Goodbye!
```

### Interactive Mode Commands
- `quit` - Exit the interactive session
- `exit` - Exit the interactive session
- `q` - Quick exit

## 📋 Common Use Cases

### 1. File Management
```bash
# Navigate and explore
nlcmd "go to my Documents folder"
nlcmd "show me all PDF files"
nlcmd "find files created today"

# File operations
nlcmd "copy file.txt to Downloads"
nlcmd "move old.txt to trash"
nlcmd "rename file.txt to new.txt"
```

### 2. System Monitoring
```bash
# System health
nlcmd "check if my system is running well"
nlcmd "show me what's using the most memory"
nlcmd "check disk usage by folder"

# Process management
nlcmd "show me all running applications"
nlcmd "find processes using lots of CPU"
```

### 3. Development Workflow
```bash
# Git workflow
nlcmd "check what files I've changed"
nlcmd "add all my changes"
nlcmd "commit with message 'fix bug'"
nlcmd "push my changes"

# Package management
nlcmd "install the latest version of node"
nlcmd "update all my python packages"
```

### 4. Network and Connectivity
```bash
# Network diagnostics
nlcmd "check if I'm connected to the internet"
nlcmd "show me my IP address"
nlcmd "test connection to google.com"
```

## 🎯 Tips for Better Results

### 1. Be Specific
✅ **Good:**
```bash
nlcmd "show me all python files in the current directory"
nlcmd "check disk space on my main drive"
```

❌ **Avoid:**
```bash
nlcmd "show files"
nlcmd "check space"
```

### 2. Use Natural Language
✅ **Good:**
```bash
nlcmd "install a package called htop"
nlcmd "create a new folder called projects"
```

❌ **Avoid:**
```bash
nlcmd "install htop"
nlcmd "mkdir projects"
```

### 3. Provide Context
✅ **Good:**
```bash
nlcmd "show me what's in my Downloads folder"
nlcmd "check git status in my current project"
```

❌ **Avoid:**
```bash
nlcmd "show downloads"
nlcmd "git status"
```

## 🔧 Command Confirmation

Every command requires confirmation before execution:

```
🤖 I understood: 'show me the current directory'
📝 Command to execute: pwd

❓ Do you want to execute this command? (y/n): 
```

- **y** or **Y** - Execute the command
- **n** or **N** - Cancel the command
- Any other key - Cancel the command

## 🚨 Safety Features

### 1. Command Preview
- Always see the exact command before execution
- Understand what will happen before confirming

### 2. Confirmation Required
- No automatic execution
- User must approve every command

### 3. Error Handling
- Graceful handling of AI failures
- Helpful error messages
- Suggestions for better requests

## 📊 Performance Tips

### 1. Keep Ollama Running
```bash
# Check if Ollama is running
brew services list | grep ollama

# Start if needed
brew services start ollama
```

### 2. Use Appropriate Models
```bash
# For general use
ollama run llama2 "your request"

# For coding tasks
ollama run codellama "your request"
```

### 3. Batch Operations
- Use interactive mode for multiple related commands
- Single command mode for quick one-offs

## 🎉 Next Steps

Now that you understand the basics:

1. **Try the examples** above
2. **Experiment** with your own requests
3. **Read the Advanced Usage Guide** for more complex scenarios
4. **Check the Troubleshooting Guide** if you encounter issues

---

**Happy natural language terminaling! 🚀**
