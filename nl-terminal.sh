#!/bin/bash

# Natural Language Terminal Interface
# Uses Ollama to understand natural language and execute terminal commands

# Function to get command from Ollama
get_command() {
    local prompt="$1"
    
    # Create a system prompt that instructs the LLM to return only shell commands
    local system_prompt="You are a helpful assistant that converts natural language requests into shell commands. 
    IMPORTANT: Respond with ONLY the shell command, nothing else. No explanations, no markdown, just the command.
    Examples:
    - 'show me the current directory' -> 'pwd'
    - 'list all files' -> 'ls -la'
    - 'check disk space' -> 'df -h'
    - 'find all python files' -> 'find . -name \"*.py\"'
    - 'show running processes' -> 'ps aux'
    - 'check network connections' -> 'netstat -tuln'
    - 'show system info' -> 'uname -a'
    - 'check memory usage' -> 'free -h' (Linux) or 'vm_stat' (macOS)
    - 'install a package' -> 'brew install <package>' (macOS)
    - 'update system' -> 'brew update && brew upgrade' (macOS)
    - 'create a directory' -> 'mkdir <dirname>'
    - 'copy files' -> 'cp <source> <destination>'
    - 'move files' -> 'mv <source> <destination>'
    - 'delete files' -> 'rm <filename>'
    - 'search for text in files' -> 'grep -r \"text\" .'
    - 'compress files' -> 'tar -czf <archive.tar.gz> <files>'
    - 'extract archive' -> 'tar -xzf <archive.tar.gz>'
    - 'check git status' -> 'git status'
    - 'commit changes' -> 'git add . && git commit -m \"message\"'
    - 'push to remote' -> 'git push'
    - 'pull from remote' -> 'git pull'
    - 'check python version' -> 'python3 --version'
    - 'install python package' -> 'pip3 install <package>'
    - 'run a python script' -> 'python3 <script.py>'
    - 'check node version' -> 'node --version'
    - 'install node package' -> 'npm install <package>'
    - 'run a node script' -> 'node <script.js>'
    
    For macOS specific commands, use brew for package management and appropriate macOS utilities.
    Always return the most appropriate command for the current operating system (macOS in this case)."
    
    # Get command from Ollama
    local command=$(ollama run llama2 "$system_prompt

User request: $prompt

Command:" 2>/dev/null | tail -n 1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    echo "$command"
}

# Function to execute command with confirmation
execute_command() {
    local command="$1"
    local original_prompt="$2"
    
    echo "🤖 I understood: '$original_prompt'"
    echo "�� Command to execute: $command"
    echo ""
    
    # Ask for confirmation
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
}

# Main function
main() {
    echo "🤖 Natural Language Terminal Interface"
    echo "💡 Powered by Ollama + Llama2"
    echo "📝 Type your request in natural language (or 'quit' to exit)"
    echo ""
    
    while true; do
        echo -n "💬 You: "
        read -r user_input
        
        # Check for quit command
        if [[ "$user_input" == "quit" || "$user_input" == "exit" || "$user_input" == "q" ]]; then
            echo "👋 Goodbye!"
            break
        fi
        
        # Skip empty input
        if [[ -z "$user_input" ]]; then
            continue
        fi
        
        echo "🤔 Thinking..."
        
        # Get command from Ollama
        command=$(get_command "$user_input")
        
        # Check if we got a valid command
        if [[ -n "$command" && "$command" != "null" && "$command" != "None" ]]; then
            execute_command "$command" "$user_input"
        else
            echo "❌ Sorry, I couldn't understand how to convert that to a command."
            echo "💡 Try being more specific about what you want to do."
        fi
        
        echo ""
    done
}

# Run main function
main
