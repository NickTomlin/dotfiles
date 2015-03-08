## got to git root directory
## http://stackoverflow.com/a/957978/1048479
function groot() {
  cd "$(git rev-parse --show-toplevel)"
}
# base64 encode a file,
## source: @mathias-bynens comment to  http://superuser.com/a/120815/146376
## @todo format this into a css data url
base64() {
  openssl base64 < $1 | tr -d '\n' | pbcopy
}
# copy
## Copies User's sshkey to clipboard
## @todo: have a general "copy" alias to use in linux + darwin?
sshkey() {
  if exists pbcopy; then
    pbcopy < ${HOME}/.ssh/id_rsa.pub
    echo "sshkey copied to clipboard. Have fun"
  fi
}

# make a directory and cd into it
# http://theunixgeek.blogspot.com/2009/02/merging-mkdir-and-cd.html
mcd() { [ -n "$1"  ] && mkdir -p "$1" && cd "$1";  }

# Search Google for terms
## http://superuser.com/questions/47192/google-search-from-linux-terminal
google() {
    search=""
    echo "$1"
    for term in $*; do
        search="$search%20$term"
    done
    $open "http://www.google.com/search?q=$search"
}

# Get a Python Module's directory (inspired by: http://stackoverflow.com/a/15211581/1048479)
## optionally, cd to the given path by adding the optional argument "-go"
pmodule() {
  pmodule_path="$(dirname $(echo "t=__import__(\"$1\",fromlist=[\".\"]); print(t.__file__)" | python ))"
  echo "$1 source: $pmodule_path
  dir stored in ENV \$pmodule_path; use the '-go' flag to cd to directory"
  if [[ "$2" == "-go" ]]; then
    cd $pmodule_path
  fi
}

# download index.html from HTML5BP
html5() {
  curl -O https://raw.github.com/h5bp/html5-boilerplate/master/index.html
}

# convenience to scale canvas of image (downscaling does not quite work)
scaleCanvas() {
  if exists convert; then
    cp $1 $1.bak
    mogrify -gravity center -background transparent -extent $2 $1
  else
    echo "convert not found, is ImageMagick installed and in your path?"
  fi
}

# Check for existence of program
exists () {
  hash $1 2>/dev/null
}

# Start a python simple HTTP server. This is superseded, for the most part, by node's static (``npm install -g static``)
## http://docs.python.org/2/library/simplehttpserver.html#module-SimpleHTTPServer
serve() {
  if [[ -z "$1" ]]; then
      echo "No port supplied. Using 3000"
      PORT=3000
  else
    PORT="$1"
  fi
  echo "\033[38;5;148m Starting on $PORT, Have Fun!\033[39m"
  python -m SimpleHTTPServer $PORT
}

# cd into whatever is the forefront Finder window.
## Stolen from paul irish's dotfiles: https://github.com/paulirish/dotfiles/commit/e67d1bc03
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

