export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:/usr/local/share/npm/bin:$PATH"
# enable colors in terminal

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1
# print the current directory in the bash prompt (http://goo.gl/GnkKz)
export PS1="[\u@\h \w]\\$ "

# Enable Homebrew completions if available
if command -v brew >/dev/null 2>&1; then
    brew_completion="$(brew --prefix)/etc/bash_completion"
    [ -f "$brew_completion" ] && . "$brew_completion"
    unset brew_completion
fi

# Ignore duplicate entries in history http://goo.gl/NKJ2N
export HISTCONTROL=ignoredups

# Ignore certain commands http://stackoverflow.com/questions/4747337/how-can-ignore-more-than-one-commands-from-history
export HISTIGNORE="&:ls:exit"

### EDITING
export EDITOR=nvim
