.PHONY: minikube
minikube:
	@sudo systemctl start libvirtd
	@sudo systemctl start virtlogd
	@minikube start --nodes 4 -p sandbox

.PHONY: stop
stop:
	@sudo systemctl stop libvirtd
	@sudo systemctl stop virtlogd

.PHONY: purge
purge: stop
	@minikube delete -p sandbox

.PHONY: setup
setup:
	@./setup.sh
