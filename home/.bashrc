export PATH="/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin:$PATH"
# source our aliases file
[[ -s "$HOME/.local_aliases" ]] && source "$HOME/.local_aliases";
# enable colors in terminal

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1
# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# print the current directory in the bash prompt (http://goo.gl/GnkKz)
export PS1="[\u@\h \w]\\$ "

# enable bash completion (?)
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Ignore duplicate entries in history http://goo.gl/NKJ2N
export HISTCONTROL=ignoredups

# Ignore certain commands http://stackoverflow.com/questions/4747337/how-can-ignore-more-than-one-commands-from-history
export HISTIGNORE="&:ls:exit"

### EDITING
# make vim the default editor
export EDITOR=/usr/bin/vim

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
