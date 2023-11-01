.PHONY: minikube
minikube:
	@echo 'Starting Minikube Installation'
	@sudo systemctl start libvirtd
	@sudo systemctl start virtlogd
	@minikube start --nodes 2 -p sandbox

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

.PHONY: istio
istio:
	@echo 'Starting Istio Installation'
	kubectl create namespace istio-system
	helm install istio-base istio/base -n istio-system --set defaultRevision=default
	helm install istiod istio/istiod -n istio-system --wait
	helm status istiod -n istio-system
	kubectl create namespace istio-ingress
	istioctl install -f istio/ingress.yaml
	kubectl label namespace default istio-injection=enabled

.PHONY: reset
reset: stop purge setup minikube istio

