#!/bin/bash

# Natural Language Command Executor
# Usage: nl-cmd "your natural language request"

if [ $# -eq 0 ]; then
    echo "Usage: nl-cmd \"your natural language request\""
    echo "Example: nl-cmd \"show me the current directory\""
    exit 1
fi

prompt="$*"

# System prompt for command conversion
system_prompt="You are a shell command generator. Convert natural language to shell commands.

RULES:
1. Respond with ONLY the shell command
2. No explanations, no markdown, no quotes
3. Just the raw command

EXAMPLES:
- 'show me the current directory' -> pwd
- 'list all files' -> ls -la
- 'check disk space' -> df -h
- 'find all python files' -> find . -name \"*.py\"
- 'show running processes' -> ps aux
- 'check network connections' -> netstat -tuln
- 'show system info' -> uname -a
- 'check memory usage' -> vm_stat
- 'install a package' -> brew install <package>
- 'update system' -> brew update && brew upgrade
- 'create a directory' -> mkdir <dirname>
- 'copy files' -> cp <source> <destination>
- 'move files' -> mv <source> <destination>
- 'delete files' -> rm <filename>
- 'search for text in files' -> grep -r \"text\" .
- 'compress files' -> tar -czf <archive.tar.gz> <files>
- 'extract archive' -> tar -xzf <archive.tar.gz>
- 'check git status' -> git status
- 'commit changes' -> git add . && git commit -m \"message\"
- 'push to remote' -> git push
- 'pull from remote' -> git pull
- 'check python version' -> python3 --version
- 'install python package' -> pip3 install <package>
- 'run a python script' -> python3 <script.py>
- 'check node version' -> node --version
- 'install node package' -> npm install <package>
- 'run a node script' -> node <script.js>

For macOS, use brew for package management."

# Get command from Ollama
command=$(ollama run llama2 "$system_prompt

User request: $prompt

Command:" 2>/dev/null | grep -v "^$" | tail -n 1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [[ -n "$command" && "$command" != "null" && "$command" != "None" ]]; then
    echo "🤖 I understood: '$prompt'"
    echo "�� Command to execute: $command"
    echo ""
    read -p "❓ Do you want to execute this command? (y/n): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🚀 Executing command..."
        echo "----------------------------------------"
        eval "$command"
        echo "----------------------------------------"
        echo "✅ Command completed!"
    else
        echo "❌ Command cancelled."
    fi
else
    echo "❌ Sorry, I couldn't understand how to convert '$prompt' to a command."
    echo "💡 Try being more specific about what you want to do."
fi
