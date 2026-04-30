# Minimal two-line prompt: [~/path] [git-branch]
# ❯ green on success, red on failure
# Inspired by sorin-modified.zsh-theme in this repo

autoload -Uz vcs_info
precmd_functions+=(vcs_info)
zstyle ':vcs_info:git:*' formats ' %F{3}%b%f'
zstyle ':vcs_info:*' enable git

setopt prompt_subst
PROMPT='%F{12}[%~]${vcs_info_msg_0_}
%(?:%F{2}:%F{1})❯%f '
