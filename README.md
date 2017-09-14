## Build the image and tag it as dev-latest

`docker build -t nodehttp:dev-latest .`

## Delete any previous nodehttp deployment and service
`kubectl delete deployment,svc nodehttp`

## Use Makefile to create deployment and service and mounting volumes
```bash
make create
make local
make mount
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

* Create the nodehttp deployment and specify which port you want to expose
  * Add `--dry-run -o yaml > deployment.yaml` to create conf file
  * `kubectl run nodehttp --image=nodehttp:dev-latest --port=8081`
* Expose the previously created deployment
  * Add `--dry-run -o yaml > svc.yaml` to create conf file
  * `kubectl expose deployment nodehttp --type=NodePort`
