# Script de desarrollo Python para ExpenseIA

param(
    [string]$Action = "help"
)

function Show-Help {
    Write-Host "🐍 Script de desarrollo Python para ExpenseIA" -ForegroundColor Green
    Write-Host "`nUso: .\scripts\python-dev.ps1 [comando]" -ForegroundColor Yellow
    Write-Host "`nComandos disponibles:" -ForegroundColor Cyan
    Write-Host "  setup     - Configurar entorno Python" -ForegroundColor White
    Write-Host "  activate  - Activar entorno virtual" -ForegroundColor White
    Write-Host "  run       - Ejecutar servidor de desarrollo" -ForegroundColor White
    Write-Host "  test      - Ejecutar tests" -ForegroundColor White
    Write-Host "  install   - Instalar dependencias" -ForegroundColor White
    Write-Host "  update    - Actualizar dependencias" -ForegroundColor White
    Write-Host "  clean     - Limpiar entorno" -ForegroundColor White
    Write-Host "  deactivate - Desactivar entorno" -ForegroundColor White
}

# Navegar al directorio de Python
Set-Location "control-gastos-ia/python"

switch ($Action.ToLower()) {
    "setup" {
        Write-Host "🔧 Configurando entorno Python..." -ForegroundColor Yellow
        if (-not (Test-Path "venv")) {
            python -m venv venv
            Write-Host "✅ Entorno virtual creado" -ForegroundColor Green
        }
        & ".\venv\Scripts\Activate.ps1"
        pip install -r requirements.txt
        Write-Host "✅ Entorno configurado" -ForegroundColor Green
    }
    "activate" {
        Write-Host "🔌 Activando entorno virtual..." -ForegroundColor Yellow
        & ".\venv\Scripts\Activate.ps1"
    }
    "run" {
        Write-Host "🚀 Ejecutando servidor de desarrollo..." -ForegroundColor Yellow
        & ".\venv\Scripts\Activate.ps1"
        python main.py
    }
    "test" {
        Write-Host "🧪 Ejecutando tests..." -ForegroundColor Yellow
        & ".\venv\Scripts\Activate.ps1"
        python -m pytest tests/ -v
    }
    "install" {
        Write-Host "📚 Instalando dependencias..." -ForegroundColor Yellow
        & ".\venv\Scripts\Activate.ps1"
        pip install -r requirements.txt
    }
    "update" {
        Write-Host "🔄 Actualizando dependencias..." -ForegroundColor Yellow
        & ".\venv\Scripts\Activate.ps1"
        pip install --upgrade -r requirements.txt
    }
    "clean" {
        Write-Host "🧹 Limpiando entorno..." -ForegroundColor Yellow
        if (Test-Path "venv") {
            Remove-Item -Recurse -Force "venv"
            Write-Host "✅ Entorno virtual eliminado" -ForegroundColor Green
        }
        if (Test-Path "__pycache__") {
            Remove-Item -Recurse -Force "__pycache__"
            Write-Host "✅ Cache de Python eliminado" -ForegroundColor Green
        }
    }
    "deactivate" {
        Write-Host "🔌 Desactivando entorno virtual..." -ForegroundColor Yellow
        deactivate
    }
    default {
        Show-Help
    }
}


