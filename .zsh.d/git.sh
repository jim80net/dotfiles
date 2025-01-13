alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gpuocf='git push --set-upstream origin $(git symbolic-ref --short HEAD) --force-with-lease'
alias gpuamend="git commit --amend --no-edit && git push --force-with-lease"
alias gst="git status"

# Thanks https://github.com/rtyley/bfg-repo-cleaner/issues/187#issuecomment-1474230546
function rl-objects() {
  git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | sed -n 's/^blob //p'
}
function rl-objects-by-size() {
  rl-objects \
    | sort -k2 -nr \
    | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

function rl-objects-by-path() {
  rl-objects \
    | sort -k3 \
    | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}


function git() {
  case $* in
    objects-by-size) rl-objects-by-size ;;
    objects-by-path) rl-objects-by-path ;;
    * ) command git "$@" ;;
	esac
}
