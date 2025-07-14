Write-Output "Локальный кластер и приложение запущены."
k3d-up:
	# Создаем кластер k3d, если еще не создан
	k3d cluster create mycluster --api-port 6550 -p "8080:80@loadbalancer" --servers 1 --agents 2
	# Устанавливаем контекст kubectl на новый кластер
	kubectl cluster-info --context=k3d-mycluster

	# Устанавливаем или обновляем релиз
	helm upgrade --install myapp ./charts/myapp --namespace default --create-namespace