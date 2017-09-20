# k8s test

I used this project to setup a local kubernetes cluster with two pods.
Each pod contains a container with a Node.js application:
* **nodeclient** which exposes an HTTP server on the 8081 with 2 endpoints:
  * `/` => you can use it to get the homepage (to test mounted volumes, see `make mount`)
  * `/connect.html` => you can use it to make a client connect to
    the server living in the other pod (nodeserver) via DNS service discovery

## Use Makefile to create deployment and service and mounting volumes
```bash
make create
make local
make mount
make delete
```

## Get the URL to access the nodehttp service
`minikube service nodehttp --url`

## Access the logs
`kubectl logs POD_NAME -c nodehttp`

*To get the POD_NAME do* `kubectl get pod`.

## Getting inside the container
`kubectl exec -it POD_NAME -c nodehttp -- /bin/bash`

*To get the POD_NAME do* `kubectl get pod`.

## Alternatively here are some commands to handle deployment/svc one by one

* Delete any previous nodehttp deployment and service
  * `kubectl delete deployment,svc nodehttp`
* Create the nodehttp deployment and specify which port you want to expose
  * Add `--dry-run -o yaml > deployment.yaml` to create conf file
  * `kubectl run nodehttp --image=nodehttp:dev-latest --port=8081`
* Expose the previously created deployment
  * Add `--dry-run -o yaml > svc.yaml` to create conf file
  * `kubectl expose deployment nodehttp --type=NodePort`
