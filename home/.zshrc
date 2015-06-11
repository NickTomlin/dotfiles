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

# --- PATH
# prefer user packages to system ones
# @todo trim this down?
export PATH='/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin'

# --- Shell Options
# Make sure to fix the horribly slow git completion with https://github.com/bobthecow/git-flow-completion/wiki/Update-Zsh-git-completion-module
EDITOR='vim' # emacs sucks. J/K. Not really.
export EDITOR

# Prevents zsh from messing with tmux window title http://superuser.com/a/320316
DISABLE_AUTO_TITLE=true

## Autocomplete
autoload -U compinit
compinit

autoload -U select-word-style
select-word-style bash

### @borked Reverse tab in autocomplete http://stackoverflow.com/a/842370/1048479
# bindkey '^[[Z' reverse-menu-complete

## VI Mode ^^
# set -o vi
set -o emacs

### Edit command line (http://nuclearsquid.com/writings/edit-long-commands/)
autoload -U edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

### provide reverse I search in vi mode
bindkey "^R" history-incremental-search-backward

#### quick-switch to command mode (http://superuser.com/a/353127/146376)
bindkey '^j' vi-cmd-mode

## Default `cd` to pushd/popd
setopt autopushd

# Smart quote urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## pager
export PAGER="less"
export LESS="-R"
export LC_CTYPE=$LANG

## History
## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=500
SAVEHIST=1000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Ignore certain commands http://stackoverflow.com/questions/4747337/how-can-ignore-more-than-one-commands-from-history
export HISTIGNORE="&:ls:exit:ll:l:fg"

### Remove duplicates
export HISTCONTROL=erasedups

### Timestamps with history entries
#@BORKED export HISTTIMEFORMAT="%F %T "

# --- OS
setopt auto_cd
setopt multios
setopt cdablevarS

if [[ $(uname -s) == "Darwin" ]]
  then
    autoload colors; colors;
    export LSCOLORS="Gxfxcxdxbxegedabagacad"
    alias ls='ls -G'
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

# --- buitins
## Display stack number next to directory listing
alias dirs='dirs -v'

# mkdir
## have mkdir create parent directories
alias mkdir='mkdir -pv'

# cd
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

# ls niceities
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# history
alias history='fc -l 1'

# grep
alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}'

# --- "Portable" bash aliases
alias zshrc='$EDITOR ~/.zshrc'
alias blog='$EDITOR ~/Dropbox/sync/octoblog-drafts'
alias vimsimple='vim -u ~/.vim/simple-vimrc'
alias t='tmux'
alias tat='tmux attach -t'
alias team='teamocil'
alias g='git'

# --- Convenience
## Print the current date (for backups, etc)
nicedate=$(date +%m-%d-%y)
## Avoid a screen full of vendor junk when using tree
alias tree="tree -I 'node_modules|vendor'"
## Line numbers with cat
alias catn='cat -n'
## Open changed files in vim
alias editchanged='vim `git status --porcelain | sed -ne '\''s/^ M //p'\''`'

######
# FUNCTIONS
######
source ~/.terminal_config/functions.zsh

######
# Language Specific
######

# --- RUBY

## RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias rh="rbenv rehash"
alias be="bundle exec"

# --- NODE

## NVM
if [[ $(uname -s) == "Darwin" ]]
  then
    export NVM_DIR=~/.nvm
    [[ -s $(brew --prefix nvm)/nvm.sh ]] && source $(brew --prefix nvm)/nvm.sh
  else
    [[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
fi

# on probation due to possible shell slowness:
# [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
# nvm alias default 0.10 && nvm use default;

# make it easier to run things in node_modules
alias npm-exec='env PATH="$(npm bin):$PATH"'
alias ne='npm-exec'

# --- PYTHON
# @todo manually source virtualenvwrapper instead of using venv burrito (fix python3 incompatibility)
# [pyenv](https://github.com/yyuu/pyenv)
# eval "$(pyenv init -)"

######
# PAAS related tools
######

# Heroku
# [[ -d "/usr/bin/heroku" ]] && export PATH="/usr/local/heroku/bin:$PATH"

######
# Kick off the pretty stuff
######

# --- Homeschick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
alias h="homeshick"

# --- Z yo
. "$HOME/z.sh"

# local config / aliases
[[ -s "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases";

# --- Themeing
# pretty colors -- REQUIRED for spectrum support
setopt prompt_subst
# shorthand for colors
source ~/.terminal_config/spectrum.zsh

source ~/.terminal_config/sorin-modified.zsh-theme
