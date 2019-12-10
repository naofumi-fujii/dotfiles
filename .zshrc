setopt nonomatch

# autocomplete
autoload -U compinit && compinit

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=${JAVA_HOME}/bin:${PATH}

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:$(brew --prefix)/share/git-core/contrib/diff-highlight

export LANG=ja_JP.UTF-8

alias ls="gls --color=auto -Slah"
alias vi='nvim'

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

setopt autopushd
setopt pushd_ignore_dups

function chpwd() {
  ls
}

zstyle ':completion:*:default' menu select=2

export HISTFILE=${HOME}/.zsh_history

export HISTSIZE=1000

export SAVEHIST=100000

setopt hist_ignore_all_dups

setopt extended_history

setopt append_history

autoload colors && colors

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

eval "$(nodenv init -)"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

set -o ignoreeof

setopt share_history

# keybinds
bindkey -d
bindkey -e

function peco-select-dir () {
  local PASSED=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$PASSED" ]; then
    BUFFER="cd ${PASSED}"
    zle accept-line
  fi
}
zle -N peco-select-dir
bindkey "^]" peco-select-dir

function peco-select-branch () {
  local selected_branch_name="$(git branch -a | peco | sed -e 's/^*/ /g' | tr -d ' ')"
  case "$selected_branch_name" in
    *-\>* )
      selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')";;
    remotes* )
      selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')";;
  esac
  if [ -n "$selected_branch_name" ]; then
    BUFFER="git checkout ${selected_branch_name}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-select-branch
bindkey '^g' peco-select-branch

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
    eval $tac | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function git-ls-files-vim () {
  local PASSED=$(git ls-files | peco --query "$LBUFFER")
  #local PASSED=$(tree -N -if | peco --query "$LBUFFER")
  if [ -n "$PASSED" ]; then
    BUFFER="vi ${PASSED}"
    zle accept-line
  fi
}
zle -N git-ls-files-vim
bindkey '^t' git-ls-files-vim

unset zle_bracketed_paste

function git-open () {
  hub browse
}
zle -N git-open
bindkey '^o' git-open


eval "$(hub alias -s)"


WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


eval $(thefuck --alias)

# $ rename "hoge" "fuga" -d app/views
#function rename(){
#  codemod --extensions rb,erb,haml,json,c,go $@
#}

function gg() {
  if [ -n "$1" ]; then
    git grep -I -n --perl-regexp "$1" -- ':!:*.svg' . | peco --exec 'awk -F : '"'"'{print "-c" $2 " " $1}'"'"' | xargs -o nvim'
  else
    rg . -n --color never | peco --exec 'awk -F : '"'"'{print "-c" $2 " " $1}'"'"' | xargs -o nvim'
  fi
}

export EDITOR=$(which nvim)

# haskell-ide-engine
export PATH=$HOME/.local/bin:$PATH

# zsh-completions
if [ -d ${HOME}/src/github.com/zsh-users/zsh-completions/src ] ; then
  fpath=(${HOME}/src/github.com/zsh-users/zsh-completions/src $fpath)
  compinit
fi



# prompt
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' formats '%s][%F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }

PROMPT='
[${vcs_info_msg_0_}][%D{%y/%m/%f}|%*]
%{${fg[yellow]}%}%~%{${reset_color}%}
[%n] $ '
