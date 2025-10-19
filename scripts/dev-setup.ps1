# Script de configuración para desarrollo ExpenseIA

Write-Host "🚀 Configurando entorno de desarrollo ExpenseIA..." -ForegroundColor Green

# Verificar Docker
Write-Host "📦 Verificando Docker..." -ForegroundColor Yellow
docker --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker no está instalado. Instálalo desde: https://www.docker.com/products/docker-desktop" -ForegroundColor Red
    exit 1
}

# Crear archivo .env si no existe
if (-not (Test-Path ".env")) {
    Write-Host "📝 Creando archivo .env..." -ForegroundColor Yellow
    @"
# Base de datos
DB_HOST=localhost
DB_PORT=5432
DB_NAME=expense_ai
DB_USER=postgres
DB_PASSWORD=expense_ai_password

# JWT
JWT_SECRET=tu_secreto_jwt_muy_largo_y_seguro_para_expense_ai_2024

# OpenAI (para IA)
OPENAI_API_KEY=tu_api_key_de_openai_aqui

# Redis
REDIS_URL=redis://localhost:6379
"@ | Out-File -FilePath ".env" -Encoding UTF8
    Write-Host "✅ Archivo .env creado. Configura tus variables de entorno." -ForegroundColor Green
}

# Construir y ejecutar contenedores
Write-Host "🔨 Construyendo contenedores..." -ForegroundColor Yellow
docker-compose build

Write-Host "🚀 Iniciando servicios..." -ForegroundColor Yellow
docker-compose up -d

Write-Host "✅ Entorno configurado correctamente!" -ForegroundColor Green
Write-Host "🌐 Backend: http://localhost:8080" -ForegroundColor Cyan
Write-Host "🤖 IA Service: http://localhost:8000" -ForegroundColor Cyan
Write-Host "🗄️  PostgreSQL: localhost:5432" -ForegroundColor Cyan
Write-Host "📊 Redis: localhost:6379" -ForegroundColor Cyan

Write-Host "`n📋 Comandos útiles:" -ForegroundColor Yellow
Write-Host "  docker-compose logs -f          # Ver logs" -ForegroundColor White
Write-Host "  docker-compose down             # Detener servicios" -ForegroundColor White
Write-Host "  docker-compose restart          # Reiniciar servicios" -ForegroundColor White




