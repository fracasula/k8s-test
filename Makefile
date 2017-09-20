.PHONY: local create delete
CLIENT=nodeclient
SERVER=nodeserver

local:
	@eval $$(minikube docker-env) ;\
	docker image build -t $(CLIENT):dev-latest -f ./client/Dockerfile .
	docker image build -t $(SERVER):dev-latest -f ./server/Dockerfile .
	kubectl set image -f ./deploy/nodeclient_deployment.yaml $(CLIENT)=$(CLIENT):dev-latest
	kubectl set image -f ./deploy/nodeserver_deployment.yaml $(SERVER)=$(SERVER):dev-latest

create:
	@eval $$(minikube docker-env) ;\
	docker image build -t $(CLIENT):dev-latest -f ./client/Dockerfile .
	docker image build -t $(SERVER):dev-latest -f ./server/Dockerfile .
	kubectl create -f ./deploy

delete:
	kubectl delete -f ./deploy

mount:
	@echo "Setting up mount as symlink in /Users/.minikube-mounts folder"
	$(shell sudo mkdir /Users/.minikube-mounts)
	$(shell sudo ln -s ${PWD}/website /Users/.minikube-mounts/nodeclient)
	@echo $(shell ls /Users/.minikube-mounts)
