#!/bin/bash

# Natural Language Terminal Interface - Installation Script
# This script automates the installation of all required components

set -e  # Exit on any error

echo "🤖 Natural Language Terminal Interface - Installation Script"
echo "=========================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only."
    exit 1
fi

print_status "Checking system requirements..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_error "Homebrew is not installed. Please install it first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi
print_success "Homebrew is installed"

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed. Please install it first."
    exit 1
fi
print_success "Python 3 is available"

print_status "Installing Ollama..."
if ! command -v ollama &> /dev/null; then
    brew install ollama
    print_success "Ollama installed successfully"
else
    print_success "Ollama is already installed"
fi

print_status "Starting Ollama service..."
brew services start ollama
print_success "Ollama service started"

print_status "Downloading Llama2 model (this may take a few minutes)..."
if ! ollama list | grep -q "llama2"; then
    ollama pull llama2
    print_success "Llama2 model downloaded successfully"
else
    print_success "Llama2 model is already available"
fi

print_status "Setting up shell scripts..."

# Create the scripts directory if it doesn't exist
mkdir -p ~/nl-terminal

# Copy scripts to the directory
if [ -f "nl-cmd.sh" ]; then
    cp nl-cmd.sh ~/nl-terminal/
    chmod +x ~/nl-terminal/nl-cmd.sh
    print_success "nl-cmd.sh copied and made executable"
else
    print_warning "nl-cmd.sh not found in current directory"
fi

if [ -f "nl-terminal.sh" ]; then
    cp nl-terminal.sh ~/nl-terminal/
    chmod +x ~/nl-terminal/nl-terminal.sh
    print_success "nl-terminal.sh copied and made executable"
else
    print_warning "nl-terminal.sh not found in current directory"
fi

print_status "Configuring shell aliases..."

# Check if aliases already exist
if ! grep -q "alias nl=" ~/.zshrc; then
    echo 'alias nl="~/nl-terminal/nl-terminal.sh"' >> ~/.zshrc
    print_success "Added 'nl' alias"
else
    print_success "'nl' alias already exists"
fi

if ! grep -q "alias nlcmd=" ~/.zshrc; then
    echo 'alias nlcmd="~/nl-terminal/nl-cmd.sh"' >> ~/.zshrc
    print_success "Added 'nlcmd' alias"
else
    print_success "'nlcmd' alias already exists"
fi

# Add Python bin to PATH if not already there
if ! grep -q "Library/Python/3.9/bin" ~/.zshrc; then
    echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
    print_success "Added Python bin to PATH"
else
    print_success "Python bin already in PATH"
fi

print_status "Reloading shell configuration..."
source ~/.zshrc
print_success "Shell configuration reloaded"

print_status "Testing installation..."

# Test if Ollama is responding
if ollama run llama2 "test" &> /dev/null; then
    print_success "Ollama is responding correctly"
else
    print_error "Ollama is not responding. Please check the service status."
    exit 1
fi

# Test if scripts are accessible
if command -v nlcmd &> /dev/null; then
    print_success "nlcmd command is available"
else
    print_error "nlcmd command not found. Please check the installation."
    exit 1
fi

if command -v nl &> /dev/null; then
    print_success "nl command is available"
else
    print_error "nl command not found. Please check the installation."
    exit 1
fi

echo ""
echo "🎉 Installation completed successfully!"
echo ""
echo "📖 Usage Examples:"
echo "  nlcmd \"show me the current directory\""
echo "  nlcmd \"list all files\""
echo "  nlcmd \"check disk space\""
echo "  nl"
echo ""
echo "🔧 Available Commands:"
echo "  nl     - Start interactive natural language terminal"
echo "  nlcmd  - Execute a single natural language command"
echo ""
echo "📚 For more information, see the README.md file"
echo ""
print_success "Natural Language Terminal Interface is ready to use!" 
