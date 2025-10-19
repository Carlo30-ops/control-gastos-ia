# Script de desarrollo con Docker para ExpenseIA

param(
    [string]$Action = "help"
)

function Show-Help {
    Write-Host "🐳 Script de desarrollo Docker para ExpenseIA" -ForegroundColor Green
    Write-Host "`nUso: .\scripts\docker-dev.ps1 [comando]" -ForegroundColor Yellow
    Write-Host "`nComandos disponibles:" -ForegroundColor Cyan
    Write-Host "  start     - Iniciar todos los servicios" -ForegroundColor White
    Write-Host "  stop      - Detener todos los servicios" -ForegroundColor White
    Write-Host "  restart   - Reiniciar todos los servicios" -ForegroundColor White
    Write-Host "  logs      - Ver logs en tiempo real" -ForegroundColor White
    Write-Host "  status    - Ver estado de contenedores" -ForegroundColor White
    Write-Host "  build     - Construir imagenes" -ForegroundColor White
    Write-Host "  clean     - Limpiar contenedores e imagenes" -ForegroundColor White
    Write-Host "  backend   - Acceder al contenedor backend" -ForegroundColor White
    Write-Host "  ai        - Acceder al contenedor de IA" -ForegroundColor White
    Write-Host "  db        - Acceder a la base de datos" -ForegroundColor White
}

switch ($Action.ToLower()) {
    "start" {
        Write-Host "🚀 Iniciando servicios..." -ForegroundColor Yellow
        docker-compose up -d
    }
    "stop" {
        Write-Host "🛑 Deteniendo servicios..." -ForegroundColor Yellow
        docker-compose down
    }
    "restart" {
        Write-Host "🔄 Reiniciando servicios..." -ForegroundColor Yellow
        docker-compose restart
    }
    "logs" {
        Write-Host "📋 Mostrando logs en tiempo real..." -ForegroundColor Yellow
        docker-compose logs -f
    }
    "status" {
        Write-Host "📊 Estado de contenedores:" -ForegroundColor Yellow
        docker-compose ps
    }
    "build" {
        Write-Host "🔨 Construyendo imagenes..." -ForegroundColor Yellow
        docker-compose build --no-cache
    }
    "clean" {
        Write-Host "🧹 Limpiando contenedores e imagenes..." -ForegroundColor Yellow
        docker-compose down --volumes --remove-orphans
        docker system prune -f
    }
    "backend" {
        Write-Host "🔧 Accediendo al contenedor backend..." -ForegroundColor Yellow
        docker-compose exec backend bash
    }
    "ai" {
        Write-Host "🤖 Accediendo al contenedor de IA..." -ForegroundColor Yellow
        docker-compose exec ai_service bash
    }
    "db" {
        Write-Host "🗄️ Accediendo a la base de datos..." -ForegroundColor Yellow
        docker-compose exec postgres psql -U postgres -d expense_ai
    }
    default {
        Show-Help
    }
}