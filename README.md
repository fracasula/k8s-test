# k8s test

I used this project to setup a local kubernetes cluster with two pods.
Each pod contains a container with a Node.js application:

* **nodeserver** which exposes a simple server listening on the 1337
* **nodeclient** which exposes an HTTP server on the 8081 with 2 endpoints:
  * `/` => you can use it to get the homepage (to test mounted volumes, see `make mount`)
  * `/connect.html` => you can use it to make a client connect to
    the server living in the other pod (**nodeserver**) via DNS service discovery

## Steps to test this project

1. `make mount`
2. `make create`
3. Get the **nodeclient** HTTP server address by doing `minikube service nodeclient --url`
4. Call the **nodeclient** HTTP server homepage (see bullet 3 above, e.g. `http://192.168.99.100:31144`)
   to test your mounted volume
   * you can make some changes to the `website/index.html` file and reload the page to see if it works
5. Call the **nodeclient** `/connect.html` endpoint to test if the DNS service discovery works
   (e.g. `http://192.168.99.100:31144/connect.html`)

## Use Makefile to create deployments and services and mounting volumes
```bash
make create
make local
make mount
make delete
```

## Get the URL to access the nodeclient service
`minikube service nodeclient --url`

## Access the logs
`kubectl logs POD_NAME -c nodeclient`

*To get the POD_NAME do* `kubectl get pod`.

## Getting inside the container
`kubectl exec -it POD_NAME -c nodeclient -- /bin/bash`

*To get the POD_NAME do* `kubectl get pod`.

## Alternatively here are some commands to handle deployment/svc one by one

* Delete any previous nodeclient deployment and service
  * `kubectl delete deployment,svc nodeclient`
* Create the nodeclient deployment and specify which port you want to expose
  * Add `--dry-run -o yaml > deployment.yaml` to create conf file
  * `kubectl run nodeclient --image=nodeclient:dev-latest --port=8081`
* Expose the previously created deployment
  * Add `--dry-run -o yaml > svc.yaml` to create conf file
  * `kubectl expose deployment nodeclient --type=NodePort`
