HISTFILE=~/.histfile
HISTSIZE=4096
SAVEHIST=4096
setopt appendhistory


# aliases
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias feh='feh -d'
alias vls="vim +'browse old'"
alias v="vim"
alias D='date +%m%d%y'
alias pgrep='pgrep -a'
alias arecord='arecord -f dat'
alias journalctl='journalctl -xe'

# ruby gems bin path
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# vim mode
bindkey -v

# completion TODO
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES
zstyle ':completion:*' menu select
# activate approximate completion, but only after regular completion (_complete)
zstyle ':completion:::::' completer _complete _approximate
# limit to 2 errors
zstyle ':completion:*:approximate:*' max-errors 2
# caseless (errorless) substring matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# autostart x at login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

# mute pc speaker
unsetopt beep

# transparency
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" >/dev/null

# Keep track of other people accessing the box
watch=( all )
export LOGCHECK=30
export WATCHFMT=$'\e[00;00m\e[01;36m'" -- %n@%m has %(a.logged in.logged out) --"$'\e[00;00m'

#prompt config
autoload -Uz promptinit
promptinit
#prompt redhat
PROMPT='%F{cyan}[%n@%m %~]%f$ '

# color output
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
man() {
  LESS_TERMCAP_md=$'\E[1;36m'
  LESS_TERMCAP_me=$'\E[0m'
  LESS_TERMCAP_so=$'\E[01;44;33m'
  LESS_TERMCAP_se=$'\E[0m'
  LESS_TERMCAP_us=$'\E[1;32m'
  LESS_TERMCAP_ue=$'\E[0m'
  command man "$@"
}

# vim edit mode
bindkey -v
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% VIMODE]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

bindkey "^R" history-incremental-search-backward
bindkey '^W' backward-kill-word
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history
bindkey '^[[3~' delete-char            # Del
bindkey '^?' backward-delete-char      # Backspace

#syntax hl
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

