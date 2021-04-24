function k-delete-services () {
    snap run kubectl get services | grep -v NAME | awk '{print $1}' | xargs snap run kubectl delete service
}

function k-delete-deployments () {
    snap run kubectl get deployments | grep -v NAME | awk '{print $1}' | xargs snap run kubectl delete deployment
}
