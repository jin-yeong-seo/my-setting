# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH



#export LC_ALL=en_KR.UTF-8

#load tab completions
autoload -Uz compinit && compinit -u

#load fzf setting
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LC_ALL=en_US.UTF-8

plugins=(
  git
  fzf
)


#fzf settings
export FZF_DEFAULT_COMMAND='fd --hidden'
export FZF_DEFAULT_OPTS="--reverse --preview 'tree -C {} | head -50'"

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS=$FZF_DEFAULT_OPTS

#rust settings
export PATH=$PATH:$HOME/.cargo/bin/
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library

#go settings
export GOPATH=$HOME/.goprojects
export PATH=$PATH:$GOPATH/bin

#python settings
export PATH=$PATH:/Users/issacseo/Library/Python/3.9/bin/


export PS1="%~
$ "


export CPPFLAGS="-I/usr/local/opt/openjdk/include"


export PATH=$PATH:/opt/local/bin
export MANPATH=$MANPATH:/opt/local/share/man
export INFOPATH=$INFOPATH:/opt/local/share/info

alias py2='python'
alias py3='python3'
alias q='exit'
alias emacs='emacs -nw'
alias vi='/usr/local/bin/vim'
alias vim='nvim'


export PATH="/usr/local/opt/openjdk/bin:$PATH"
