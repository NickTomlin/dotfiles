# Cross-platform shell functions

# cd to git repository root
groot() {
  cd "$(git rev-parse --show-toplevel)"
}

# mkdir and cd into it
mcd() { [[ -n "$1" ]] && mkdir -p "$1" && cd "$1"; }

# Check whether a command exists
exists() { hash "$1" 2>/dev/null; }

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
