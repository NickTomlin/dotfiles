# Cross-platform shell functions

# cd to git repository root
groot() {
  cd "$(git rev-parse --show-toplevel)"
}

# mkdir and cd into it
mcd() { [[ -n "$1" ]] && mkdir -p "$1" && cd "$1"; }

# Check whether a command exists
exists() { hash "$1" 2>/dev/null; }

# Copy the default SSH public key to the clipboard
sshkey() {
  local key
  for key in "$HOME/.ssh/id_ed25519.pub" "$HOME/.ssh/id_rsa.pub"; do
    if [[ -r "$key" ]]; then
      copy < "$key" || return 1
      echo "SSH public key copied to clipboard."
      return
    fi
  done
  echo "No SSH public key found" >&2
  return 1
}

# Start a local HTTP server
serve() {
  local port="${1:-3000}"
  echo "Starting HTTP server on port $port"
  python3 -m http.server "$port"
}

# Print the filesystem path of an installed Python module
pmodule() {
  local path
  path="$(python3 -c "import $1; import os; print(os.path.dirname($1.__file__))")"
  echo "$1 source: $path"
  [[ "$2" == "-go" ]] && cd "$path"
}
