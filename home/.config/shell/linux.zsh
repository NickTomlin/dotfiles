# Linux-specific shell configuration

# User local bin (pip install --user, cargo install, etc.)
export PATH="$HOME/.local/bin:$PATH"

# JetBrains Toolbox CLI scripts
[[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]] &&
  export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

# Clipboard helpers (requires xclip or xsel)
if command -v xclip &>/dev/null; then
  copy() { xclip -selection clipboard; }
  paste() { xclip -selection clipboard -o; }
elif command -v xsel &>/dev/null; then
  copy() { xsel --clipboard --input; }
  paste() { xsel --clipboard --output; }
fi

if command -v xclip &>/dev/null || command -v xsel &>/dev/null; then
  alias pbcopy='copy'
  alias pbpaste='paste'
fi

# Cross-platform tool inits (activate only if installed)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
if ! command -v fnm &>/dev/null && [[ -x "$HOME/.local/share/fnm/fnm" ]]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
fi
command -v fnm &>/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
