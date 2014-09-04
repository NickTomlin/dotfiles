######
#  oooooooooooo  .oooooo..o ooooo   ooooo      ooo        ooooo       .o.         .oooooo.    ooooo   .oooooo.
# d'""""""d888' d8P'    `Y8 `888'   `888'      `88.       .888'      .888.       d8P'  `Y8b   `888'  d8P'  `Y8b
#       .888P   Y88bo.       888     888        888b     d'888      .8"888.     888            888  888
#      d888'     `"Y8888o.   888ooooo888        8 Y88. .P  888     .8' `888.    888            888  888
#    .888P           `"Y88b  888     888        8  `888'   888    .88ooo8888.   888     ooooo  888  888
#   d888'    .P oo     .d8P  888     888        8    Y     888   .8'     `888.  `88.    .88'   888  `88b    ooo
# .8888888888P  8""88888P'  o888o   o888o      o8o        o888o o88o     o8888o  `Y8bood8P'   o888o  `Y8bood8P'
##############
# Legend:
# @todo: future feature
# @consider: education/possibility
# @borked: broken. Fix it!

# Theme notes:
# Font: http://damieng.com/blog/2007/11/14/droid-font-family-courtesy-of-google-ascender
# Iterm: Theme: https://github.com/baskerville/iTerm-2-Color-Themes arthur

######
# Zsh Configuration
######

ZSH=$HOME/.oh-my-zsh
# set custom path for personal themes/plugins
ZSH_CUSTOM=$HOME/.terminal_config

# --- Homeschick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# --- PATH
# prefer user packages to system ones
export PATH='/usr/local/bin:/usr/local/sbin:/usr/local/lib:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin'
# local config / aliases
[[ -s "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases";

# --- Themeing
# found in ~/.terminal_config/sorin-modified.zsh-theme
export ZSH_THEME="sorin-modified" # Sweet git magic

# --- PLUGINS (~/.oh-my-zsh/plugins/*) ---
plugins=(git django)
source $ZSH/oh-my-zsh.sh

# --- Shell Options
## set editor
### @todo consider switching back to ST2?
EDITOR='vim'  # emacs sucks. J/K. Not really.
export EDITOR

# Prevents zsh from messing with tmux window title http://superuser.com/a/320316
DISABLE_AUTO_TITLE=true

## Autocomplete
### @borked Reverse tab in autocomplete http://stackoverflow.com/a/842370/1048479
# bindkey '^[[Z' reverse-menu-complete

## Files
### have mkdir create parent directories
alias mkdir='mkdir -pv'

## History
### Histsize
HISTSIZE=1000

### Remove duplicates
export HISTCONTROL=erasedups
### Timestamps with history entries
#@BORKED export HISTTIMEFORMAT="%F %T "

## Default `cd` to pushd/popd
setopt autopushd

## Display stack number next to directory listing
alias dirs='dirs -v'

## VI Mode ^^
set -o vi

### Edit command line (http://nuclearsquid.com/writings/edit-long-commands/)
autoload -U edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# @borked using `subl` (works with EDITOR set to 'vim' though!)
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

### provide reverse I search in vi mode
bindkey "^R" history-incremental-search-backward

#### quick-switch to command mode (http://superuser.com/a/353127/146376)
bindkey '^j' vi-cmd-mode

# Make sure to fix the horribly slow git completion with https://github.com/bobthecow/git-flow-completion/wiki/Update-Zsh-git-completion-module
# @consider https://github.com/webflo/drush_zsh_completion

# --- OS

if [[ $(uname -s) == "Darwin" ]]
  then
    # @todo Use MacVim instead of Vim (for system keyboard stuff, etc)
    # Should probably check if this exists before setting, but that'll come later
    # alias vim=/usr/local/Cellar/macvim/7.3-65/MacVim.app/Contents/MacOS/vim
    # this may need to happen within local alises, since installed version differs from system to system
    # or: symlink macvim to bin and then access it there?
    # or: grep for it?
    open=open
  else
    open=xdg-open # consider prepending 'detach' to free up process on open [source](http://unix.stackexchange.com/a/74622/38479)
fi

######
# ALIASES
######

# --- "Portable" bash aliases
alias zshrc='$EDITOR ~/.zshrc'
alias blog='$EDITOR ~/Dropbox/sync/octoblog-drafts'
alias vimsimple='vim -u ~/.vim/simple-vimrc'
alias t='tmux'
alias tat='tmux attach -t'
alias team='teamocil'

# --- Convenience
## Print the current date (for backups, etc)
nicedate=$(date +%m-%d-%y)
## Avoid a screen full of vendor junk when using tree
alias tree="tree -I 'node_modules|vendor'"
## Line numbers with cat
alias catn='cat -n'
## Open changed files in vim
alias editchanged='vim `git status --porcelain | sed -ne '\''s/^ M //p'\''`'
## got to git root directory
## http://stackoverflow.com/a/957978/1048479
function groot() {
  cd "$(git rev-parse --show-toplevel)"
}

######
# FUNCTIONS (@todo consider moving to a seperate file)
######
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

######
# Language Specific
######

# --- RUBY

## RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias be="bundle exec"

# --- NODE

## NVM
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh" && nvm alias default 0.10; nvm use default;
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# --- PYTHON
# @todo manually source virtualenvwrapper instead of using venv burrito (fix python3 incompatibility)

######
# PAAS related tools
######

# Heroku
[[ -d "/usr/bin/heroku" ]] && export PATH="/usr/local/heroku/bin:$PATH"
