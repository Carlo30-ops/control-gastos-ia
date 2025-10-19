# Script simple para verificar Docker

Write-Host "🐳 Verificando Docker..." -ForegroundColor Green

# Verificar si Docker está disponible
try {
    $dockerVersion = docker --version 2>$null
    if ($dockerVersion) {
        Write-Host "✅ Docker encontrado: $dockerVersion" -ForegroundColor Green
    } else {
        throw "Docker no disponible"
    }
} catch {
    Write-Host "❌ Docker no está disponible en el PATH" -ForegroundColor Red
    Write-Host "📋 Pasos para configurar:" -ForegroundColor Yellow
    Write-Host "  1. Reinicia tu computadora" -ForegroundColor White
    Write-Host "  2. Abre Docker Desktop desde el menú de inicio" -ForegroundColor White
    Write-Host "  3. Espera a que Docker Desktop termine de inicializar" -ForegroundColor White
    Write-Host "  4. Ejecuta este script nuevamente" -ForegroundColor White
    exit 1
}

# Verificar si Docker está ejecutándose
try {
    docker ps > $null 2>&1
    Write-Host "✅ Docker está ejecutándose" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker no está ejecutándose" -ForegroundColor Red
    Write-Host "🔧 Inicia Docker Desktop y ejecuta este script nuevamente" -ForegroundColor Yellow
    exit 1
}

# Probar Docker con hello-world
Write-Host "🧪 Probando Docker con hello-world..." -ForegroundColor Yellow
try {
    docker run --rm hello-world
    Write-Host "✅ Docker funciona correctamente!" -ForegroundColor Green
} catch {
    Write-Host "❌ Error probando Docker" -ForegroundColor Red
    exit 1
}

Write-Host "`n🎉 Docker está configurado correctamente!" -ForegroundColor Green
Write-Host "Ahora puedes ejecutar: .\scripts\docker-setup.ps1" -ForegroundColor Cyan

