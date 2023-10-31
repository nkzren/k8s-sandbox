#!/bin/bash

setup_minikube() {
	# Check minikube installed
	if ! command -v minikube &> /dev/null; then
		MINIKUBE_PATH=$HOME/.local/bin/minikube
		echo "Minikube not installed. Installing now on $MINIKUBE_PATH"
		curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
		install minikube-linux-amd64 $MINIKUBE_PATH && rm minikube-linux-amd64
	else
		echo "Minikube already installed. Will not try to install again"
	fi

	echo "Copy minikube config file"
	MINIKUBE_CONFIG_PATH=$HOME/.minikube/config
	[ ! -d $MINIKUBE_CONFIG_PATH ] && mkdir -p $MINIKUBE_CONFIG_PATH

	cp ./minikube-config.json $MINIKUBE_CONFIG_PATH/config.json
}

setup_minikube
