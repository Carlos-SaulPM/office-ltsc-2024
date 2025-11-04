@echo off
title Instalador Office LTSC 2024
color 0A
setlocal enabledelayedexpansion

echo ==================================================
echo   Instalador de Microsoft Office LTSC 2024
echo   Version: Word, Excel, PowerPoint, Publisher
echo ==================================================
echo.

REM --- Cambiar a la carpeta temporal donde se ejecuta ---
cd /d "%~dp0"

REM --- Verificar privilegios de administrador ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Este instalador debe ejecutarse como administrador.
    echo.
    pause
    exit /b
)

REM --- Descargar herramienta de implementación (ODT) si no existe ---
if not exist setup.exe (
    echo Descargando la herramienta de implementación de Office (ODT)...
    powershell -Command "Invoke-WebRequest -Uri 'https://download.microsoft.com/download/2/7/D/27D13F97-19F4-4DB8-8F5A-8F7F2E31F16D/officedeploymenttool_16827-20290.exe' -OutFile 'odt.exe'" >nul 2>&1
    if exist odt.exe (
        echo Extrayendo setup.exe...
        start /wait odt.exe /quiet
        del odt.exe >nul 2>&1
    ) else (
        echo [ERROR] No se pudo descargar la herramienta de implementación.
        pause
        exit /b
    )
)

REM --- Verificar archivo config.xml ---
if not exist config.xml (
    echo [ERROR] No se encuentra el archivo config.xml.
    pause
    exit /b
)

REM --- Instalar Office ---
echo Instalando Microsoft Office LTSC 2024...
echo (Este proceso puede tardar varios minutos, por favor espere)
setup.exe /configure config.xml

if %errorlevel% equ 0 (
    echo.
    echo ==================================================
    echo Instalación completada correctamente.
    echo ==================================================
) else (
    echo.
    echo [ERROR] Hubo un problema durante la instalación. Código: %errorlevel%
)

pause
endlocal
exit /b
