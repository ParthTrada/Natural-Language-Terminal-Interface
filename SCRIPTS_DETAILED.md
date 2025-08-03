# 🔧 Scripts Detailed Documentation

This document provides in-depth technical information about the natural language terminal scripts.

## 📋 Overview

The project consists of two main bash scripts that integrate with Ollama to provide natural language command execution:

1. **`nl-cmd.sh`**: Single command executor
2. **`nl-terminal.sh`**: Interactive terminal interface

## 🛠️ nl-cmd.sh - Single Command Executor

### Purpose
Execute one-off natural language commands with confirmation.

### Usage
```bash
nlcmd "your natural language request"
```

### Code Structure

#### 1. Argument Validation
```bash
if [ $# -eq 0 ]; then
    echo "Usage: nl-cmd \"your natural language request\""
    echo "Example: nl-cmd \"show me the current directory\""
    exit 1
fi
```
- Checks if arguments are provided
- Shows usage information if no arguments
- Exits with error code 1

#### 2. System Prompt Definition
```bash
system_prompt="You are a shell command generator. Convert natural language to shell commands.

RULES:
1. Respond with ONLY the shell command
2. No explanations, no markdown, no quotes
3. Just the raw command

EXAMPLES:
- 'show me the current directory' -> pwd
- 'list all files' -> ls -la
..."
```
- Defines the AI's role and behavior
- Provides clear examples for command conversion
- Ensures consistent output format

#### 3. Ollama Integration
```bash
command=$(ollama run llama2 "$system_prompt

User request: $prompt

Command:" 2>/dev/null | grep -v "^$" | tail -n 1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
```
- Calls Ollama with the system prompt and user request
- Redirects stderr to /dev/null to suppress warnings
- Filters out empty lines with `grep -v "^$"`
- Takes the last line of output with `tail -n 1`
- Trims whitespace with `sed`

#### 4. Command Validation
```bash
if [[ -n "$command" && "$command" != "null" && "$command" != "None" ]]; then
    # Execute command
else
    echo "❌ Sorry, I couldn't understand how to convert '$prompt' to a command."
fi
```
- Checks if command is not empty
- Validates against common null responses
- Provides helpful error message

#### 5. Safety Confirmation
```bash
read -p "❓ Do you want to execute this command? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Execute command
else
    echo "❌ Command cancelled."
fi
```
- Always asks for user confirmation
- Uses regex pattern matching for yes/no
- Provides clear feedback

#### 6. Command Execution
```bash
echo "🚀 Executing command..."
echo "----------------------------------------"
eval "$command"
echo "----------------------------------------"
echo "✅ Command completed!"
```
- Shows execution status
- Uses `eval` to execute the command
- Provides visual feedback

### Error Handling
- **Argument validation**: Exits gracefully if no arguments provided
- **Ollama errors**: Suppresses stderr to avoid confusion
- **Empty responses**: Validates AI output before execution
- **User cancellation**: Handles user rejection gracefully

## 🛠️ nl-terminal.sh - Interactive Terminal Interface

### Purpose
Provide continuous natural language interaction with the terminal.

### Usage
```bash
nl
```

### Code Structure

#### 1. Command Generation Function
```bash
get_command() {
    local prompt="$1"
    
    local system_prompt="You are a helpful assistant that converts natural language requests into shell commands. 
    IMPORTANT: Respond with ONLY the shell command, nothing else. No explanations, no markdown, just the command.
    Examples:
    - 'show me the current directory' -> 'pwd'
    - 'list all files' -> 'ls -la'
    ..."
    
    local command=$(ollama run llama2 "$system_prompt

User request: $prompt

Command:" 2>/dev/null | tail -n 1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    echo "$command"
}
```
- Encapsulates command generation logic
- Uses local variables for scope isolation
- Returns the generated command

#### 2. Command Execution Function
```bash
execute_command() {
    local command="$1"
    local original_prompt="$2"
    
    echo "🤖 I understood: '$original_prompt'"
    echo "📝 Command to execute: $command"
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
}
```
- Handles command execution with confirmation
- Shows user what was understood
- Provides visual feedback during execution

#### 3. Main Loop Function
```bash
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
```
- Provides user interface
- Handles exit conditions
- Manages conversation flow
- Provides helpful error messages

### Key Features

#### 1. Exit Conditions
```bash
if [[ "$user_input" == "quit" || "$user_input" == "exit" || "$user_input" == "q" ]]; then
    echo "👋 Goodbye!"
    break
fi
```
- Multiple ways to exit
- Clear goodbye message
- Breaks the main loop

#### 2. Empty Input Handling
```bash
if [[ -z "$user_input" ]]; then
    continue
fi
```
- Skips empty inputs
- Prevents unnecessary AI calls
- Maintains conversation flow

#### 3. Error Recovery
```bash
if [[ -n "$command" && "$command" != "null" && "$command" != "None" ]]; then
    execute_command "$command" "$user_input"
else
    echo "❌ Sorry, I couldn't understand how to convert that to a command."
    echo "💡 Try being more specific about what you want to do."
fi
```
- Validates AI responses
- Provides helpful suggestions
- Continues conversation after errors

## 🔧 AI Prompt Engineering

### System Prompt Design

The scripts use carefully crafted system prompts that:

1. **Define Role**: "You are a shell command generator"
2. **Set Rules**: Clear instructions for output format
3. **Provide Examples**: Common command conversions
4. **Ensure Safety**: macOS-specific commands
5. **Maintain Consistency**: Predictable output format

### Example Prompt Structure
```
You are a shell command generator. Convert natural language to shell commands.

RULES:
1. Respond with ONLY the shell command
2. No explanations, no markdown, no quotes
3. Just the raw command

EXAMPLES:
- 'show me the current directory' -> pwd
- 'list all files' -> ls -la
- 'check disk space' -> df -h
...

For macOS, use brew for package management.
```

### Prompt Optimization

#### 1. Clarity
- Clear, unambiguous instructions
- Specific examples for common tasks
- Explicit formatting requirements

#### 2. Safety
- macOS-specific commands
- Safe default behaviors
- Error handling considerations

#### 3. Consistency
- Predictable output format
- Standard command patterns
- Reliable parsing

## 🔍 Performance Considerations

### 1. Ollama Response Time
- Model size affects response time
- Llama2 provides good balance of speed/accuracy
- Consider smaller models for faster responses

### 2. Command Parsing
- Simple text processing
- Minimal regex operations
- Efficient string manipulation

### 3. Error Handling
- Graceful degradation
- Helpful error messages
- Recovery mechanisms

## 🛡️ Security Features

### 1. Command Confirmation
- Always requires user approval
- Shows exact command before execution
- Prevents accidental execution

### 2. Local Processing
- No external API calls
- Data stays on your machine
- No privacy concerns

### 3. Input Validation
- Checks for valid commands
- Prevents dangerous operations
- Provides safe defaults

## 🔧 Customization Guide

### 1. Changing the Model
```bash
# Replace llama2 with another model
ollama run codellama "your prompt"
```

### 2. Adding New Commands
Edit the system prompt to include new examples:
```bash
- 'your new request' -> your_command
```

### 3. Modifying Behavior
- Change confirmation prompts
- Adjust error messages
- Customize output formatting

### 4. Performance Tuning
- Use smaller models for speed
- Optimize prompt length
- Cache common commands

## 🐛 Debugging

### 1. Enable Debug Output
```bash
# Add to scripts for debugging
echo "DEBUG: Raw AI response: $command"
```

### 2. Test Ollama Directly
```bash
ollama run llama2 "test"
```

### 3. Check Script Permissions
```bash
ls -la ~/nl-cmd.sh ~/nl-terminal.sh
```

### 4. Verify Aliases
```bash
which nlcmd
which nl
```

## 📈 Best Practices

### 1. Script Design
- Use functions for modularity
- Implement proper error handling
- Follow bash best practices
- Add comprehensive comments

### 2. User Experience
- Provide clear feedback
- Handle edge cases gracefully
- Give helpful error messages
- Maintain conversation flow

### 3. Performance
- Minimize AI calls
- Optimize prompt design
- Use efficient text processing
- Cache when possible

### 4. Security
- Always confirm commands
- Validate AI responses
- Use safe defaults
- Provide clear feedback

---

**This documentation provides the technical foundation for understanding, maintaining, and extending the natural language terminal interface.** 
