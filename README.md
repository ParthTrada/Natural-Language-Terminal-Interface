# 🤖 Natural Language Terminal Interface

Transform your macOS terminal into an AI-powered interface that understands natural language commands. No more memorizing complex shell commands - just speak to your terminal in plain English!

## ✨ Features

- **Natural Language Processing**: Convert human language to shell commands
- **Local AI**: Powered by Ollama + Llama2 (no API keys required)
- **Safety First**: Always asks for confirmation before executing commands
- **macOS Optimized**: Uses appropriate macOS utilities and Homebrew
- **Interactive Mode**: Chat with your terminal continuously
- **Single Command Mode**: Execute one-off commands quickly

## 🚀 Quick Start

### Prerequisites

1. **macOS** (tested on macOS 14+)
2. **Homebrew** (for package management)
3. **Python 3.9+** (for additional tools)

### Installation

1. **Install Ollama** (Local LLM):
   ```bash
   brew install ollama
   brew services start ollama
   ```

2. **Download Llama2 Model**:
   ```bash
   ollama pull llama2
   ```

3. **Download the Scripts**:
   ```bash
   # Clone this repository or download the scripts manually
   # Make sure nl-cmd.sh and nl-terminal.sh are in your home directory
   ```

4. **Make Scripts Executable**:
   ```bash
   chmod +x ~/nl-cmd.sh
   chmod +x ~/nl-terminal.sh
   ```

5. **Add to Your Shell Configuration**:
   ```bash
   # Add these lines to your ~/.zshrc file
   echo 'alias nl="~/nl-terminal.sh"' >> ~/.zshrc
   echo 'alias nlcmd="~/nl-cmd.sh"' >> ~/.zshrc
   echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

## 📖 Usage

### Interactive Mode
Start a continuous conversation with your terminal:
```bash
nl
```

Example session:
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

### Single Command Mode
Execute one-off commands:
```bash
nlcmd "your natural language request"
```

Examples:
```bash
nlcmd "show me the current directory"
nlcmd "list all files in this directory"
nlcmd "check disk space usage"
nlcmd "show running processes"
nlcmd "install a package called htop"
nlcmd "update my system"
nlcmd "create a new directory called test"
nlcmd "check git status"
nlcmd "commit my changes"
nlcmd "push to remote"
```

## 🔧 Supported Commands

The AI understands a wide variety of natural language requests and converts them to appropriate shell commands:

### File System Operations
- "show me the current directory" → `pwd`
- "list all files" → `ls -la`
- "create a directory called [name]" → `mkdir [name]`
- "copy [file] to [destination]" → `cp [file] [destination]`
- "move [file] to [destination]" → `mv [file] [destination]`
- "delete [file]" → `rm [file]`
- "find all python files" → `find . -name "*.py"`

### System Information
- "check disk space" → `df -h`
- "show running processes" → `ps aux`
- "check system information" → `uname -a`
- "check memory usage" → `vm_stat` (macOS)
- "check network connections" → `netstat -tuln`

### Package Management (macOS)
- "install a package called [name]" → `brew install [name]`
- "update my system" → `brew update && brew upgrade`
- "install python package [name]" → `pip3 install [name]`
- "install node package [name]" → `npm install [name]`

### Git Operations
- "check git status" → `git status`
- "commit my changes" → `git add . && git commit -m "message"`
- "push to remote" → `git push`
- "pull from remote" → `git pull`

### Development Tools
- "check python version" → `python3 --version`
- "check node version" → `node --version`
- "run a python script [name]" → `python3 [name]`
- "run a node script [name]" → `node [name]`

### File Operations
- "search for text in files" → `grep -r "text" .`
- "compress files" → `tar -czf [archive.tar.gz] [files]`
- "extract archive" → `tar -xzf [archive.tar.gz]`

## 📁 Script Details

### nl-cmd.sh
**Purpose**: Single command execution mode
**Usage**: `nlcmd "natural language request"`
**Features**:
- Takes a natural language request as an argument
- Converts it to a shell command using Ollama
- Asks for confirmation before execution
- Displays the command that will be executed

### nl-terminal.sh
**Purpose**: Interactive conversation mode
**Usage**: `nl` (alias)
**Features**:
- Continuous conversation with the terminal
- Type natural language requests
- Exit with 'quit', 'exit', or 'q'
- Real-time command conversion and execution

## 🔍 How It Works

1. **Natural Language Input**: You provide a request in plain English
2. **AI Processing**: Ollama + Llama2 processes your request
3. **Command Generation**: The AI converts your request to appropriate shell commands
4. **Safety Check**: The system shows you the command and asks for confirmation
5. **Execution**: If confirmed, the command is executed in your terminal

## 🛠️ Technical Architecture

### Components
- **Ollama**: Local LLM server running Llama2
- **nl-cmd.sh**: Single command executor
- **nl-terminal.sh**: Interactive terminal interface
- **Shell Aliases**: Quick access commands

### AI Prompt Engineering
The scripts use carefully crafted system prompts that:
- Instruct the AI to return only shell commands
- Provide examples for common operations
- Optimize for macOS-specific commands
- Ensure safety by avoiding dangerous operations

### Safety Features
- **Confirmation Required**: All commands require user confirmation
- **Command Preview**: Shows exactly what will be executed
- **Local Processing**: No data sent to external services
- **Error Handling**: Graceful handling of AI failures

## 🔧 Customization

### Adding New Commands
Edit the system prompt in both scripts to add new command patterns:

```bash
# In the system_prompt variable, add new examples:
- 'your new request' -> your_command
```

### Using Different Models
Change the model in the scripts:
```bash
# Replace llama2 with another model
ollama run codellama "your prompt"
```

### Installing Additional Models
```bash
# Install more models for different use cases
ollama pull codellama    # For coding help
ollama pull mistral      # Fast and efficient
ollama pull llama2:7b    # Smaller, faster version
```

## 🐛 Troubleshooting

### Common Issues

1. **"Command not found: nl"**
   - Make sure you've added the aliases to your ~/.zshrc
   - Run `source ~/.zshrc` to reload

2. **"Ollama is not running"**
   - Start Ollama: `brew services start ollama`
   - Check status: `brew services list | grep ollama`

3. **"Model not found"**
   - Download the model: `ollama pull llama2`
   - Check available models: `ollama list`

4. **Script permission denied**
   - Make executable: `chmod +x ~/nl-cmd.sh ~/nl-terminal.sh`

5. **AI not understanding requests**
   - Try being more specific: "show me all files" instead of "list stuff"
   - Check that Ollama is responding: `ollama run llama2 "test"`

### Debug Mode
To see what the AI is generating, you can temporarily modify the scripts to show the raw AI output:

```bash
# In nl-cmd.sh, add this line before the command execution:
echo "DEBUG: Raw AI response: $command"
```

## 📈 Performance Tips

1. **Use Specific Requests**: "show me python files" works better than "show files"
2. **Keep Ollama Running**: The service stays active for faster responses
3. **Use Appropriate Models**: CodeLlama for development tasks, Llama2 for general use
4. **Batch Operations**: Use interactive mode for multiple related commands

## 🔒 Security Considerations

- **Local Processing**: All AI processing happens locally on your machine
- **Command Confirmation**: You always see and approve commands before execution
- **No External APIs**: No data is sent to external services
- **User Control**: You maintain full control over what gets executed

## 🤝 Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Areas for Improvement
- Support for more complex command chains
- Integration with more LLM models
- Better error handling and recovery
- Support for other operating systems
- GUI interface option

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Acknowledgments

- **Ollama Team**: For the excellent local LLM framework
- **Meta**: For the Llama2 model
- **Homebrew**: For making package management easy on macOS

## 📞 Support

If you encounter issues or have questions:

1. Check the troubleshooting section above
2. Review the script comments for debugging
3. Open an issue on GitHub with detailed information
4. Include your macOS version and Ollama version

---

**Happy coding with your AI-powered terminal! 🚀**
