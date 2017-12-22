fish_vi_key_bindings

set -gx PATH ~/.gem/ruby/2.4.0/bin $PATH
set -gx PATH ~/.yarn/bin/ $PATH
set -gx PATH ~/.local/bin/ $PATH
set -gx NODE_PATH ~/.config/yarn/global/node_modules

#set -gx PATH ~/proj/kframework/k/k-distribution/target/release/k/bin $PATH
set -gx MAVEN_OPTS -XX:+TieredCompilation

set fish_greeting "  ><>"

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
alias ghci='stack ghci'
alias red='redshift -O 3500'
alias redx='redshift -x'

alias llvm-config='llvm-config-4.0'

# restore common !! use
function sudo!!
  eval sudo $history[1]
end

# OPAM configuration
#. /home/bobak/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
