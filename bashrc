#
# ~/.bashrc
#

alias rm="rm -I"                          # confirm before deleting a lot
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
alias more=less
alias less="less -M"
alias tree="tree -a"

alias slite="light -S"
alias srs="redshift -P -O"
alias srsd="redshift -P -O 6500"
alias srsn="redshift -P -O 3500"

alias svol="amixer set 'Master'"

alias smt="(while sleep 1; do date +%X; date +%Z%A; date +%x; echo -e '\f'; done) | sm - -i -b hotpink"

alias nohist="export HISTFILE=/dev/null"

alias scrcpy='scrcpy -b2M -m800 --max-fps 15 -t --window-borderless --window-title scrcpy --render-expired-frames'

alias ytdl='youtube-dl'
tchat () { chromium --app-window-size=200,100 --app-window-position=1000,500 --app=https://www.twitch.tv/popout/"$1"/chat ; }
cdcss () { chromium --new-window https://crawl.develz.org/info http://crawl.chaosforge.org http://dcssfamiliar.com file:///home/bohadi/.crawl/morgue/chromatic.txt ; }

alias qpdfui='qpdfview --unique --instance'

alias cctv='
  streamlink http://ivi.bupt.edu.cn/hls/cctv1.m3u8     worst  &>/dev/null&  #1 general
  streamlink http://ivi.bupt.edu.cn/hls/cctv4.m3u8     worst  &>/dev/null&  #4 international
  streamlink http://ivi.bupt.edu.cn/hls/cctv13.m3u8    worst  &>/dev/null&  #13 news
  streamlink http://ivi.bupt.edu.cn/hls/cctv3.m3u8     worst  &>/dev/null&  #3 variety
  streamlink http://ivi.bupt.edu.cn/hls/cctv6.m3u8     worst  &>/dev/null&  #6 movies
  streamlink http://ivi.bupt.edu.cn/hls/cctv8.m3u8     worst  &>/dev/null&  #8 drama
  exit'
alias cctv1='
  streamlink http://ivi.bupt.edu.cn/hls/cctv1.m3u8     worst  &>/dev/null&  #1 general
  streamlink http://ivi.bupt.edu.cn/hls/cctv2.m3u8     worst  &>/dev/null&  #2 finance
  streamlink http://ivi.bupt.edu.cn/hls/cctv4.m3u8     worst  &>/dev/null&  #4 international
  streamlink http://ivi.bupt.edu.cn/hls/cctv13.m3u8    worst  &>/dev/null&  #13 news
  exit'
alias cctv2='
  streamlink http://ivi.bupt.edu.cn/hls/cctv3.m3u8     worst  &>/dev/null&  #3 variety
  streamlink http://ivi.bupt.edu.cn/hls/cctv6.m3u8     worst  &>/dev/null&  #6 movies
  streamlink http://ivi.bupt.edu.cn/hls/cctv8.m3u8     worst  &>/dev/null&  #8 drama
  streamlink http://ivi.bupt.edu.cn/hls/cctv9.m3u8     worst  &>/dev/null&  #9 documentary
  exit'

#eval "$(stack --bash-completion-script stack)"

export EDITOR=vim

#export WINEPREFIX="/home/bohadi/.local/share/wineprefixes/wine32"
#export WINEARCH="win32"
alias wechat='LC_ALL="zh_CN.UTF8" wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Tencent/WeChat/WeChat.exe'
alias zoom='LC_ALL="zh_CN.UTF8" zoom'

export GO111MODULE=auto
export GOPATH=~/go

export PATH=$PATH:~/miniconda/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.yarn/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.gem/ruby/2.6.0/bin

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"


beep() {
  s=$?
  sound_ok=~/dotfiles/ok.ogg
  sound_error=~/dotfiles/err.ogg
  let volmx=2#1111111111111111
  let vol1=2#1000111111111111
  let vol2=2#1000000111111111
  let vol3=2#1000000000111111
  if [[ $s = 0 ]]; then
    echo OK
    paplay $sound_ok --volume=$vol1
  else
    echo ERROR: $s
    paplay $sound_error --volume=$vol1
    paplay $sound_error --volume=$vol2
    paplay $sound_error --volume=$vol3
  fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bohadi/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bohadi/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/bohadi/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/bohadi/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

