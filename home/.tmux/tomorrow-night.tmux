# ** Attribution: A modified version of https://github.com/connrs/dotfiles/blob/master/tmux/tomorrow-night.tmux
# ** Colorsheme: Tomorrow night-eighties swatch: https://raw.github.com/ChrisKempson/Tomorrow-Theme/master/Images/Tomorrow-Night-Eighties-Palette.png
#
# Color key:
# 2d2d2d Background
# 393939 Current Line
# 515151 Selection
# cccccc Foreground
# 999999 Comment
# f2777a Red
# f99157 Orange
# ffcc66 Yellow
# 99cc99 Green
# 66cccc Aqua
# 6699cc Blue
# cc99cc Purple
#
# alas, something like this does not work.
# @todo find out why
# YELLOW=ffcc66

## set status bar
set -g status-bg default

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

# left side of status bar holds "(>- session name -<)"
set -g status-left-length 100
# set -g status-left-bg green
# set -g status-left-fg black
set -g status-left-attr bold
set -g status-left '#[fg=#cc99cc,bg=#2d2d2d] #H#[fg=]:#[fg=#99cc99]#S '

# right side of status bar holds "[host name] (date time)"
set -g status-right-length 100
set -g status-right-fg black
set -g status-right-attr bold
set -g status-right '#[fg=#f99157,bg=#2d2d2d] %H:%M |#[fg=#6699cc] %y.%m.%d '

# make background window look like white tab
set-window-option -g window-status-bg default
set-window-option -g window-status-fg white
set-window-option -g window-status-attr none
set-window-option -g window-status-format '#[fg=#6699cc,bg=colour235] #I #[fg=#999999,bg=#2d2d2d] #W #[default]'

# make foreground window look like bold yellow foreground tab
set-window-option -g window-status-current-attr none
set-window-option -g window-status-current-format '#[fg=#f99157,bg=#2d2d2d] #I #[fg=#cccccc,bg=#393939] #W #[default]'

# active terminal yellow border, non-active white
set -g pane-border-bg default
set -g pane-border-fg "#999999"
set -g pane-active-border-fg "#f99157"

