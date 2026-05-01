# Minimal two-line prompt: [~/path] [git-branch]
# ❯ green on success, red on failure
# Inspired by sorin-modified.zsh-theme in this repo

autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{1}*%f'
zstyle ':vcs_info:*' stagedstr '%F{2}+%f'
zstyle ':vcs_info:git:*' formats ' %F{3}%b%f%u%c'
zstyle ':vcs_info:git:*' actionformats ' %F{3}%b%f%F{1}|%a%f%u%c'

setopt prompt_subst
PROMPT='%F{12}[%~]${vcs_info_msg_0_}
%(?:%F{2}:%F{1})❯%f '
