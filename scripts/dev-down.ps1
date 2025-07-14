# Остановка и удаление локального k3d кластера

if (Get-Command k3d -ErrorAction SilentlyContinue) {
    k3d cluster delete mycluster
    Write-Output "Локальный кластер удалён."
} else {
    Write-Warning "k3d не найден."
}