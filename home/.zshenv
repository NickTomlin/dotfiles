# http://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1
# recommended by brew doctor
export PATH='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin'

# RVM
# seems to be the slowdown culprit
# [[ -s '/Users/ntomlin/.rvm/scripts/rvm' ]] && source '/Users/ntomlin/.rvm/scripts/rvm'
