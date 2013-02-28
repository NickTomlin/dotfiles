######
#  oooooooooooo  .oooooo..o ooooo   ooooo      ooo        ooooo       .o.         .oooooo.    ooooo   .oooooo.
# d'""""""d888' d8P'    `Y8 `888'   `888'      `88.       .888'      .888.       d8P'  `Y8b   `888'  d8P'  `Y8b
#       .888P   Y88bo.       888     888        888b     d'888      .8"888.     888            888  888
#      d888'     `"Y8888o.   888ooooo888        8 Y88. .P  888     .8' `888.    888            888  888
#    .888P           `"Y88b  888     888        8  `888'   888    .88ooo8888.   888     ooooo  888  888
#   d888'    .P oo     .d8P  888     888        8    Y     888   .8'     `888.  `88.    .88'   888  `88b    ooo
# .8888888888P  8""88888P'  o888o   o888o      o8o        o888o o88o     o8888o  `Y8bood8P'   o888o  `Y8bood8P'
##############

# Config notes:
# Font: http://damieng.com/blog/2007/11/14/droid-font-family-courtesy-of-google-ascender
# Iterm: Theme: https://github.com/baskerville/iTerm-2-Color-Themes arthur
# Path to your oh-my-zsh configuration.

######
# Zsh Configuration
######

ZSH=$HOME/.oh-my-zsh

# --- PATH
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/share/python:/Applications/acquia-drupal/drush:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# --- PLUGINS (~/.oh-my-zsh/plugins/*) ---
plugins=(git zshmarks osx ruby)

source $ZSH/oh-my-zsh.sh

# --- Themeing

## Load the lovely sunaku theme
export ZSH_THEME="sunaku"

# --- Shell Options

## Remove duplicates
export HISTCONTROL=erasedups

## Default `cd` to pushd/popd
setopt autopushd

## VI Mode

### provide reverse I search in vi mode
set -o vi
bindkey "^R" history-incremental-search-backward

#### quick-switch to command mode (http://superuser.com/a/353127/146376)
bindkey '^j' vi-cmd-mode

# Make sure to fix the horribly slow git completion with https://github.com/bobthecow/git-flow-completion/wiki/Update-Zsh-git-completion-module
# consider https://github.com/webflo/drush_zsh_completion

## -- OS
## Check to see if we are running on a mac, if so, use MacVim
## probably not the wisest thing to do on every session? tweak this and implement it later
# if [ $(uname -s) == "Darwin" ] # Currently borked

#   then
#     # Use MacVim instead of Vim (for system keyboard stuff, etc)
#     # Should probably check if this exists before setting, but that'll come later
#     alias vim=/usr/local/Cellar/macvim/7.3-65/MacVim.app/Contents/MacOS/vim
#     open=open

#   else
#     open=xdg-open
# fi



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

######
# Language Specific
######

# --- RUBY
## PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# RVM
## Load RVM into a shell session *as a function* (consider seeing here: https://gist.github.com/1015460)
## echo "===RVM==="
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# --- NODE

## NVM
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
