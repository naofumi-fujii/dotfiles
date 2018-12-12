for i in /etc/profile.d/*.sh ; do
  [ -r $i ] && source $i
done

setopt hist_ignore_all_dups

alias ls="ls -Slah --color"

function chpwd() {
  ls
}

function peco-select-branch () {
  local selected_branch_name="$(git branch -a | peco | tr -d ' ')"
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


function peco-select-repo () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-select-repo
bindkey '^]' peco-select-repo
