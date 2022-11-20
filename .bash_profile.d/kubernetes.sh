function get_nodes() {
    kubectl get nodes -o custom-columns=:.metadata.name
}
export -f get_nodes

function get_pods_on_node() {
    kubectl get pods --field-selector spec.nodeName=${1:?} --all-namespaces -o wide
}
export -f get_pods_on_node

# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

