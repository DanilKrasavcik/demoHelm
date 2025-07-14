SECRETS_DIR := .secrets/dev

# Имя кластера k3d
CLUSTER_NAME := mycluster

.PHONY: k3d-up inject-secrets clean

k3d-up:
	@echo "Создание кластера k3d..."
	k3d cluster create $(CLUSTER_NAME)
	
	@echo "Установка Helm-чартов..."
	helm upgrade --install my-release ./ --values ./values.yaml

inject-secrets:
	@echo "Создаю Kubernetes Secret из секретов в $(SECRETS_DIR)..."
	kubectl delete secret dev-secrets --ignore-not-found || true
	kubectl create secret generic dev-secrets \
		--from-file=api_key=$(SECRETS_DIR)/app_key \
		--from-file=db_password=$(SECRETS_DIR)/app_pass

clean:
	@echo "Удаление кластера..."
	k3d cluster delete $(CLUSTER_NAME)