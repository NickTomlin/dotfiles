# http://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1

# make it easier to run things in node_modules
alias npm-exec='env PATH="$(npm bin):$PATH"'
alias ne='npm-exec'
