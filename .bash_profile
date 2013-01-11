#! bash (hopefully this doesn't disappear)
#set our path (does git need to be in here, since it is already in usr/local/bin?
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin:/Applications/acquia-drupal/drush:$PATH"
# source our aliases file
source ~/.bash_aliases
# bashmarks
source ~/.local/bin/bashmarks.sh
# enable colors in terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# print the current directory in the bash prompt (http://goo.gl/GnkKz)
export PS1="[\u@\h \w]\\$ "
# enable bash completion (?)
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
 fi
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Export Acquia Mysql info for drush
export DRUSH_PHP=/Applications/acquia-drupal/php5_3/bin/php
export DRUSH_SQL=/Applications/acquia-drupal/mysql/bin/mysql
# Ignore duplicate entries in history http://goo.gl/NKJ2N
export HISTCONTROL=ignoredups
# Ignore certain commands http://stackoverflow.com/questions/4747337/how-can-ignore-more-than-one-commands-from-history
export HISTIGNORE="&:ls:exit"
### EDITING
# make vim the default editor 
export EDITOR=/usr/bin/vim
# enable vi editing mode in terminal (will take some getting used to, but awesome!)
set -o vi 
# Use MacVim instead of Vim (for system keyboard stuff, etc)
alias vim='/usr/local/Cellar/macvim/7.3-65/MacVim.app/Contents/MacOS/vim'