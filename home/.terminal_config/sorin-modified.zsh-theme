# vim: set syntax=zsh:
#------------------------------------------------------------------------------
#          FILE:  sorin.zsh-theme
#   DESCRIPTION:  oh-my-zsh theme file.
#        AUTHOR:  Sorin Ionescu (sorin.ionescu@gmail.com)
#      MODIFIED:  Nick Tomlin (nick.tomlin@gmail.com)
#       VERSION:  1.0.2
#    SCREENSHOT:  http://i.imgur.com/aipDQ.png
#
#    ** Miscleanous unicode symbols for fun and profit:
#    source: http://www.utf8-chartable.de/unicode-utf8-table.pl
#    ࿈ ᎒ ᐵ ࿓  ⬚ ⠮ ࿇ ⚀✪ ✍ ✎ ◆ ♻ ✪ ∆ ☦ ☭ ☢ ♨ ⚛ »
#
#    Colors can be super wacky or hard; the easiest thing is to look at spectrum.zsh
#    and use the helper function ls_spectrum
#
#    Each of the 256 numbers can be used to print a color with the %F{000} escape sequence
#
#    Or, some of the supported ANSI strings mapped by zsh
# ------------------------------------------------------------------------------

### GIT stuffz
timeout () {
  perl -e 'use Time::HiRes qw( usleep ualarm gettimeofday tv_interval ); ualarm 100000; exec @ARGV' "$@";
}

git_untracked_count() {
  count=`echo $(timeout git ls-files --other --exclude-standard | wc -l)`
  if [ $count -eq 0 ]; then return; fi
  echo " %{$fg_bold[yellow]%}?%{$fg_no_bold[black]%}:%{$reset_color$fg[yellow]%}$count%{$reset_color%}"
}

git_modified_count() {
  count=`echo $(timeout git ls-files -md | wc -l)`
  if [ $count -eq 0 ]; then return; fi
  echo " %{$fg_bold[magenta]%}M%{$fg_no_bold[black]%}:%{$reset_color$fg[red]%}$count%{$reset_color%}"
}

git_staged_count() {
  count=`echo $(timeout git diff-index --cached --name-only HEAD 2>/dev/null | wc -l)`
  if [ $count -eq 0 ]; then return; fi
  echo " %{$fg_bold[green]%}S%{$fg_no_bold[black]%}:%{$reset_color$fg[green]%}$count%{$reset_color%}"
}

git_branch() {
  branch=$(git symbolic-ref HEAD --quiet 2> /dev/null)
  if [ -z $branch ]; then
    echo "%F{3}$(git rev-parse --short HEAD)%{$reset_color%}"
  else
    echo "%F{3}${branch#refs/heads/}%{$reset_color%}"
  fi
}

git_remote_difference() {
  branch=$(git symbolic-ref HEAD --quiet)
  if [ -z $branch ]; then return; fi

  remote=$(git remote show)
  ahead_by=`echo $(git log --oneline $remote/${branch#refs/heads/}..HEAD 2> /dev/null | wc -l)`
  behind_by=`echo $(git log --oneline HEAD..$remote/${branch#refs/heads/} 2> /dev/null | wc -l)`

  output=""
  if [ $ahead_by -gt 0 ]; then output="$output%{$fg_bold[green]%}↑%{$reset_color%}$ahead_by"; fi
  if [ $behind_by -gt 0 ]; then output="$output%{$fg_bold[green]%}↓%{$reset_color%}$behind_by"; fi

  echo $output
}

in_git_repo() {
  if [[ -d .git ]]; then
    echo 0
  else
    echo $(git rev-parse --git-dir > /dev/null 2>&1; echo $?)
  fi
}

job_info() {
  JOB_COUNT="$(jobs | wc -l | xargs)" # xargs as poor man's trim http://stackoverflow.com/a/12973694
  if [ "$JOB_COUNT" = "0" ]
  then
    printf ''
  else
    printf ' (%s)' "$JOB_COUNT"
  fi
}


git_prompt_info() {
  if [[ $(in_git_repo) -gt 0 ]]; then return; fi
  print "$(git_branch)$(git_remote_difference)$(git_staged_count)$(git_modified_count)$(git_untracked_count)"
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  PROMPT='%F{12}[%~]
$(git_prompt_info)%(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%} ᎒)%{$fg_bold[blue]%}$(job_info) %{$reset_color%}'
else
  PROMPT='%c$(git_prompt_info) ᎒'
fi

