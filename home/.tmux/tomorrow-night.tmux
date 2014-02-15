# Stolen from: https://github.com/connrs/dotfiles/blob/master/tmux/tomorrow-night.tmux

## set status bar
set -g status-bg "#373b41"
set -g status-fg "#c5c8c6"

## highlight active window
setw -g window-status-current-bg "#282a2e"
setw -g window-status-current-fg "#81a2be"

## highlight activity in status bar
setw -g window-status-activity-fg "#8abeb7"
setw -g window-status-activity-bg "#1d1f21"

## pane border and colors
set -g pane-active-border-bg default
set -g pane-active-border-fg "#373b41"
set -g pane-border-bg default
set -g pane-border-fg "#373b41"

set -g clock-mode-colour "#81a2be"
set -g clock-mode-style 24

set -g message-bg "#8abeb7"
set -g message-fg "#000000"

set -g message-command-bg "#8abeb7"
set -g message-command-fg "#000000"

set -g mode-bg "#8abeb7"
set -g mode-fg "#000000"
