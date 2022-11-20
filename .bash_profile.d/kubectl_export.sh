# Prerequisites:
# [GNU Parallel](https://www.gnu.org/software/parallel/)
# [kubectl-neat](https://github.com/itaysk/kubectl-neat)
# [mikefarah/yq](https://github.com/mikefarah/yq)
#
# Usage:
# - Copy and paste the below into your active shell session. Alternatively, add to your shell initialization scripts.
# - kubectl_export <namespace>
# The folder structure will be created: <namespace>/<kind>/<resource_name>.yaml
#
# Inspired from https://www.studytonight.com/post/how-to-list-all-resources-in-a-kubernetes-namespace
# https://www.studytonight.com/post/how-to-list-all-resources-in-a-kubernetes-namespace

function kubectl_export {
  NAMESPACE=${1:?"Supply a namespace with this command"}
  mkdir -p $NAMESPACE
  kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq | parallel --tag --env NAMESPACE -- '\
    kubectl get {} -n '$NAMESPACE' 2>&1 | grep -vq "No resources found in '$NAMESPACE' namespace" && \
      mkdir -p '$NAMESPACE'/{} && \
      kubectl neat get -- {} -n '$NAMESPACE' --ignore-not-found -o yaml | yq --split-exp "\"'$NAMESPACE'/{}/\" + .metadata.name" ".items[]"
    '
}

export -f kubectl_export
