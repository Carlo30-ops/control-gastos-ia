# Script simple para iniciar Docker

Write-Host "Iniciando servicios Docker..." -ForegroundColor Green

# Verificar si Docker funciona
try {
    docker --version
    Write-Host "Docker encontrado" -ForegroundColor Green
} catch {
    Write-Host "Docker no esta disponible" -ForegroundColor Red
    exit 1
}

# Iniciar servicios
Write-Host "Iniciando contenedores..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "Servicios iniciados correctamente!" -ForegroundColor Green
    Write-Host "Backend: http://localhost:8080" -ForegroundColor Cyan
    Write-Host "IA Service: http://localhost:8000" -ForegroundColor Cyan
} else {
    Write-Host "Error iniciando servicios" -ForegroundColor Red
}


