@echo off
:: Se asegura de estar en el directorio donde se ejecuta el script (la carpeta %TEMP%)
cd /d "%~dp0"

echo "Descargando Herramienta de Implementacion de Office (ODT)..."
:: Descargar setup.exe (ODT)
curl -L -o setup.exe "https://officecdn.microsoft.com/pr/wsus/setup.exe"

echo "Descargando archivo de configuracion..."
:: Descargar config.xml
curl -L -o config.xml "https://raw.githubusercontent.com/Carlos-SaulPM/office-ltsc-2024/main/config.xml"

:: Iniciar la instalación y ESPERAR a que termine
echo "Iniciando instalacion de Office... Esto puede tardar varios minutos."
echo "La instalacion se esta realizando en segundo plano. Por favor, espere..."
start /wait setup.exe /configure config.xml

:: --- INICIO DE LIMPIEZA ---
echo "Instalacion completada. Limpiando archivos temporales..."

:: 1. Borra el instalador
if exist setup.exe (
    del setup.exe
    echo "setup.exe eliminado."
)

:: 2. Borra el archivo de configuracion
if exist config.xml (
    del config.xml
    echo "config.xml eliminado."
)

:: 3. Borra la carpeta "Office" que descarga el ODT
:: /s = borra subcarpetas y archivos, /q = modo silencioso (no pide confirmacion)
if exist "Office" (
    rd /s /q "Office"
    echo "Carpeta de instalacion 'Office' eliminada."
)

echo "Limpieza finalizada. Esta ventana se cerrara en 5 segundos..."
timeout /t 5 /nobreak > nul

:: 4. Borra el propio script .bat al salir
(goto) 2>nul & del "%~f0"