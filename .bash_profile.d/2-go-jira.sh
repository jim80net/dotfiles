eval "$(jira --completion-script-bash)"

function jira_create() {
  jira create --project=COREINF --issuetype=Story --override=summary:"${1:?}" --override=description:"${2:?}" --noedit | awk '{print $2}'
}
