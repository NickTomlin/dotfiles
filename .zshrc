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
# Helpers
######

# Check for existence of program
exists () {
  hash $1 2>/dev/null
}

######
# Zsh Configuration
######

ZSH=$HOME/.oh-my-zsh

# --- PATH
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/lib:/usr/local/share/npm/bin:/Applications/acquia-drupal/drush:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
# local config / aliases
[[ -s "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases";

# --- Themeing
export ZSH_THEME="sorin" # Sweet git magic

# --- PLUGINS (~/.oh-my-zsh/plugins/*) ---
plugins=(git zshmarks osx node ruby pip django redis-cli)
source $ZSH/oh-my-zsh.sh

# --- Shell Options
## set editor
### @todo consider switching back to ST2?
EDITOR='vim'  # emacs sucks. J/K. Not really.
export EDITOR

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

# --- local bash aliases
source ~/.bash_aliases

# --- Portable bash aliases
alias dirs='dirs -v'
alias zshrc='vim ~/.zshrc'

# --- Convenience

## Print the current date (for backups, etc)
nicedate=$(date +%m-%d-%y)

## have mkdir create parent directories
alias mkdir='mkdir -pv'


######
# FUNCTIONS (consider moving to a seperate file)
######

# Search Google for terms (linux )
## http://superuser.com/questions/47192/google-search-from-linux-terminal
google() {
    search=""
    echo "$1"
    for term in $*; do
        search="$search%20$term"
    done
    open "http://www.google.com/search?q=$search"
}

# Check if a function exists
## http://stackoverflow.com/q/85880
fn_exists() {
	    type $1 | grep -q 'shell function'
}

# Start a python simple HTTP server
## http://docs.python.org/2/library/simplehttpserver.html#module-SimpleHTTPServer
sserv() {
  if [[ -z "$1" ]]; then
      echo "No port supplied. Using 3000"
      PORT=3000
  else
    PORT="$1"
  fi
  echo "\033[38;5;148m Starting on $PORT, Have Fun!\033[39m"
  python -m SimpleHTTPServer $PORT
}

######
# Language Specific
######

# --- RUBY
## PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

## RVM
## Load RVM into a shell session *as a function* (consider seeing here: https://gist.github.com/1015460)
## echo "===RVM==="
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# --- NODE

## NVM
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh" && nvm alias default 0.8; nvm use default;
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion 
