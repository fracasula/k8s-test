.PHONY: local create delete
REPO=nodehttp

local:
	@eval $$(minikube docker-env) ;\
	docker image build -t $(REPO):dev-latest -f Dockerfile .
	kubectl set image -f ./deploy/nodehttp_deployment.yaml $(REPO)=$(REPO):dev-latest

create:
	@eval $$(minikube docker-env) ;\
	docker image build -t $(REPO):dev-latest -f Dockerfile .
	kubectl create -f deploy

delete:
	kubectl delete -f deploy

mount:
	@echo "Setting up mount as symlink in /Users/.minikube-mounts folder"
	$(shell sudo mkdir /Users/.minikube-mounts)
	$(shell sudo ln -s ${PWD}/website /Users/.minikube-mounts/nodehttp)
	@echo $(shell ls /Users/.minikube-mounts)
