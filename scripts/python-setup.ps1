# Script de configuración Python para ExpenseIA

Write-Host "🐍 Configurando entorno Python para ExpenseIA..." -ForegroundColor Green

# Verificar Python
Write-Host "📦 Verificando Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version
    Write-Host "✅ Python encontrado: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Python no está instalado." -ForegroundColor Red
    Write-Host "💡 Instala Python desde: https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# Navegar al directorio de Python
Set-Location "control-gastos-ia/python"

# Crear entorno virtual si no existe
if (-not (Test-Path "venv")) {
    Write-Host "🔧 Creando entorno virtual..." -ForegroundColor Yellow
    python -m venv venv
    Write-Host "✅ Entorno virtual creado" -ForegroundColor Green
} else {
    Write-Host "✅ Entorno virtual ya existe" -ForegroundColor Green
}

# Activar entorno virtual
Write-Host "🔌 Activando entorno virtual..." -ForegroundColor Yellow
& ".\venv\Scripts\Activate.ps1"

# Instalar dependencias
Write-Host "📚 Instalando dependencias..." -ForegroundColor Yellow
pip install -r requirements.txt

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dependencias instaladas correctamente" -ForegroundColor Green
} else {
    Write-Host "❌ Error instalando dependencias" -ForegroundColor Red
    exit 1
}

# Crear archivo .env si no existe
if (-not (Test-Path ".env")) {
    Write-Host "📝 Creando archivo .env..." -ForegroundColor Yellow
    Copy-Item "..\..\env.example" ".env"
    Write-Host "✅ Archivo .env creado" -ForegroundColor Green
}

Write-Host "`n🎉 Entorno Python configurado exitosamente!" -ForegroundColor Green
Write-Host "`n📋 Comandos útiles:" -ForegroundColor Cyan
Write-Host "  Activar entorno: .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "  Ejecutar servidor: python main.py" -ForegroundColor White
Write-Host "  Desactivar entorno: deactivate" -ForegroundColor White
Write-Host "  Instalar paquete: pip install <paquete>" -ForegroundColor White
Write-Host "  Ver paquetes: pip list" -ForegroundColor White

Write-Host "`n🌐 URLs de desarrollo:" -ForegroundColor Cyan
Write-Host "  Servidor local: http://localhost:8000" -ForegroundColor White
Write-Host "  Documentación: http://localhost:8000/docs" -ForegroundColor White
Write-Host "  Health check: http://localhost:8000/health" -ForegroundColor White


