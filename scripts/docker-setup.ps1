# Script de configuración Docker para ExpenseIA

Write-Host "🐳 Configurando Docker para ExpenseIA..." -ForegroundColor Green

# Verificar si Docker está instalado
Write-Host "📦 Verificando Docker..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker encontrado: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker no está instalado." -ForegroundColor Red
    Write-Host "📥 Instalando Docker Desktop..." -ForegroundColor Yellow
    
    # Intentar instalar con winget
    try {
        winget install Docker.DockerDesktop
        Write-Host "✅ Docker Desktop instalado. Reinicia tu computadora y ejecuta este script nuevamente." -ForegroundColor Green
        exit 0
    } catch {
        Write-Host "❌ Error instalando Docker. Instálalo manualmente desde: https://www.docker.com/products/docker-desktop" -ForegroundColor Red
        exit 1
    }
}

# Verificar si Docker está ejecutándose
Write-Host "🔍 Verificando que Docker esté ejecutándose..." -ForegroundColor Yellow
try {
    docker ps
    Write-Host "✅ Docker está ejecutándose" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker no está ejecutándose. Inicia Docker Desktop y ejecuta este script nuevamente." -ForegroundColor Red
    exit 1
}

# Crear archivo .env si no existe
if (-not (Test-Path ".env")) {
    Write-Host "📝 Creando archivo .env..." -ForegroundColor Yellow
    Copy-Item "env.example" ".env"
    Write-Host "✅ Archivo .env creado. Configura tus variables de entorno." -ForegroundColor Green
}

# Construir imágenes
Write-Host "🔨 Construyendo imágenes Docker..." -ForegroundColor Yellow
docker-compose build

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Imágenes construidas correctamente" -ForegroundColor Green
} else {
    Write-Host "❌ Error construyendo imágenes" -ForegroundColor Red
    exit 1
}

# Iniciar servicios
Write-Host "🚀 Iniciando servicios..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Servicios iniciados correctamente!" -ForegroundColor Green
    
    Write-Host "`n🌐 URLs de acceso:" -ForegroundColor Cyan
    Write-Host "  Backend (Spring Boot): http://localhost:8080" -ForegroundColor White
    Write-Host "  IA Service (Python): http://localhost:8000" -ForegroundColor White
    Write-Host "  PostgreSQL: localhost:5432" -ForegroundColor White
    Write-Host "  Redis: localhost:6379" -ForegroundColor White
    
    Write-Host "`n📋 Comandos útiles:" -ForegroundColor Yellow
    Write-Host "  docker-compose logs -f          # Ver logs en tiempo real" -ForegroundColor White
    Write-Host "  docker-compose ps               # Ver estado de contenedores" -ForegroundColor White
    Write-Host "  docker-compose down             # Detener todos los servicios" -ForegroundColor White
    Write-Host "  docker-compose restart          # Reiniciar servicios" -ForegroundColor White
    Write-Host "  docker-compose exec backend bash # Acceder al contenedor backend" -ForegroundColor White
    Write-Host "  docker-compose exec ai_service bash # Acceder al contenedor de IA" -ForegroundColor White
    
} else {
    Write-Host "❌ Error iniciando servicios" -ForegroundColor Red
    Write-Host "🔍 Revisa los logs con: docker-compose logs" -ForegroundColor Yellow
    exit 1
}



