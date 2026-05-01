# macOS-specific shell configuration


# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# JetBrains Toolbox CLI scripts
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] &&
  export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

# Clipboard helpers
copy() { pbcopy; }
paste() { pbpaste; }

# Copy SSH public key to clipboard
sshkey() {
  pbcopy < "${HOME}/.ssh/id_rsa.pub"
  echo "SSH public key copied to clipboard."
}

# base64-encode a file and copy to clipboard
base64copy() {
  openssl base64 < "$1" | tr -d '\n' | pbcopy
}

# cd to the frontmost Finder window's directory
cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Cross-platform tool inits (activate only if installed)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v fnm    &>/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
