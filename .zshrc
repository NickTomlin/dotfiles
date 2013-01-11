# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Load the lovely sunaku theme
export ZSH_THEME="sunaku"

# Remove duplicates
export HISTCONTROL=erasedups
# Default `cd` to pushd/popd
setopt autopushd

# --- PLUGINS (~/.oh-my-zsh/plugins/*)
plugins=(git zshmarks osx ruby)
# Make sure to fix the horribly slow git completion with https://github.com/bobthecow/git-flow-completion/wiki/Update-Zsh-git-completion-module
# consider https://github.com/webflo/drush_zsh_completion

# --- PATH
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin:/usr/local/share/python:/Applications/acquia-drupal/drush:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

source $ZSH/oh-my-zsh.sh

# Load RVM into a shell session *as a function* (consider seeing here: https://gist.github.com/1015460)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# --- ALIASES
# Portable bash aliases
alias dirs='dirs -v'
alias zshrc='vim ~/.zshrc'

# Grab my local bash aliases
source ~/.bash_aliases

# Use MacVim instead of Vim (for system keyboard stuff, etc)
alias vim=/usr/local/Cellar/macvim/7.3-65/MacVim.app/Contents/MacOS/vim

# --- FUNCTIONS

# Search Google for terms (linux )
# http://superuser.com/questions/47192/google-search-from-linux-terminal
google() {
    search=""
    echo "$1"
    for term in $*; do
        search="$search%20$term"
    done
    open "http://www.google.com/search?q=$search"
}

