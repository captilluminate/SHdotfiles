#!/bin/bash

#
# Test script for distribution detection
# Tests the core functionality of the universal installer
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

_log() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Test distribution detection
test_distro_detection() {
    _log "Testing distribution detection..."
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_ID="$ID"
        DISTRO_VERSION="$VERSION_ID"
        
        _log "Detected OS ID: $DISTRO_ID"
        _log "Detected Version: $DISTRO_VERSION"
        
        case "$DISTRO_ID" in
            "opensuse-tumbleweed")
                PKG_MANAGER="zypper"
                _success "openSUSE Tumbleweed detected - supported!"
                ;;
            "opensuse-slowroll")
                PKG_MANAGER="zypper"
                _success "openSUSE Slowroll detected - supported!"
                ;;
            "opensuse-leap")
                PKG_MANAGER="zypper"
                _success "openSUSE Leap detected - supported!"
                ;;
            "arch")
                PKG_MANAGER="pacman"
                _success "Arch Linux detected - supported!"
                ;;
            "ubuntu"|"debian")
                PKG_MANAGER="apt"
                _success "$DISTRO_ID detected - supported!"
                ;;
            "fedora")
                PKG_MANAGER="dnf"
                _success "Fedora detected - supported!"
                ;;
            *)
                PKG_MANAGER="unknown"
                _error "Unsupported distribution: $DISTRO_ID"
                return 1
                ;;
        esac
        
        _log "Package manager: $PKG_MANAGER"
        
        # Test if package manager is available
        if command -v "$PKG_MANAGER" &> /dev/null; then
            _success "Package manager '$PKG_MANAGER' is available"
        else
            _error "Package manager '$PKG_MANAGER' is not available"
            return 1
        fi
        
    else
        _error "/etc/os-release not found - cannot detect distribution"
        return 1
    fi
}

# Test if essential tools are available
test_essential_tools() {
    _log "Testing essential tools availability..."
    
    local tools=("git" "curl" "wget" "cmake" "gcc")
    local missing_tools=()
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            _success "$tool is available"
        else
            _error "$tool is missing"
            missing_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -eq 0 ]; then
        _success "All essential tools are available"
        return 0
    else
        _error "Missing tools: ${missing_tools[*]}"
        return 1
    fi
}

# Test dotfiles structure
test_dotfiles_structure() {
    _log "Testing dotfiles structure..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dotfiles_dir="$(dirname "$script_dir")"
    
    _log "Script directory: $script_dir"
    _log "Dotfiles directory: $dotfiles_dir"
    
    # Check for required directories
    local required_dirs=("config" "scripts")
    for dir in "${required_dirs[@]}"; do
        if [ -d "$dotfiles_dir/$dir" ]; then
            _success "Directory '$dir' exists"
        else
            _error "Directory '$dir' is missing"
            return 1
        fi
    done
    
    # Check for key files
    local key_files=("scripts/universal-install.sh" "config/fish/config.fish")
    for file in "${key_files[@]}"; do
        if [ -f "$dotfiles_dir/$file" ]; then
            _success "File '$file' exists"
        else
            _error "File '$file' is missing"
            return 1
        fi
    done
    
    _success "Dotfiles structure is valid"
}

# Main test function
main() {
    echo "=============================================="
    echo "    Universal Installer Test Suite"
    echo "=============================================="
    echo
    
    local test_results=()
    
    # Run tests
    if test_distro_detection; then
        test_results+=("distro_detection:PASS")
    else
        test_results+=("distro_detection:FAIL")
    fi
    
    echo
    
    if test_essential_tools; then
        test_results+=("essential_tools:PASS")
    else
        test_results+=("essential_tools:FAIL")
    fi
    
    echo
    
    if test_dotfiles_structure; then
        test_results+=("dotfiles_structure:PASS")
    else
        test_results+=("dotfiles_structure:FAIL")
    fi
    
    echo
    echo "=============================================="
    echo "                Test Results"
    echo "=============================================="
    
    local passed=0
    local failed=0
    
    for result in "${test_results[@]}"; do
        local test_name="${result%:*}"
        local test_status="${result#*:}"
        
        if [ "$test_status" = "PASS" ]; then
            _success "$test_name"
            ((passed++))
        else
            _error "$test_name"
            ((failed++))
        fi
    done
    
    echo
    _log "Tests passed: $passed"
    _log "Tests failed: $failed"
    
    if [ $failed -eq 0 ]; then
        _success "All tests passed! The universal installer should work on this system."
        return 0
    else
        _error "Some tests failed. Please address the issues before running the installer."
        return 1
    fi
}

main "$@"
