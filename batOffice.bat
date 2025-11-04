@echo off
:: Se asegura de estar en el directorio donde se ejecuta el script (la carpeta %TEMP%)
cd /d "%~dp0"

echo "Descargando Herramienta de Implementacion de Office (ODT)..."
curl -L -o setup.exe "https://officecdn.microsoft.com/pr/wsus/setup.exe"

echo "Descargando archivo de configuracion..."
curl -L -o config.xml "https://raw.githubusercontent.com/Carlos-SaulPM/office-ltsc-2024/main/config.xml"

:: 1. INSTALACION DE OFFICE
echo "Iniciando instalacion de Office... Esto puede tardar varios minutos."
echo "La instalacion se esta realizando en segundo plano. Por favor, espere..."
start /wait setup.exe /configure config.xml

:: ---------------------------------------------------
:: 2. SECCION DE ACTIVACION
:: ---------------------------------------------------
echo "Instalacion de Office finalizada."
echo "Iniciando script de activacion..."
echo "---"
echo "--- POR FAVOR, INTERACTUA CON LA VENTANA QUE SE ABRIRA ---"
echo "---"
echo "Presiona las opciones que necesites (ej. 2 y luego 1)"
echo "Esta ventana esperara hasta que el proceso de activacion termine."
echo "---"

:: Ejecuta el script de PowerShell y espera a que termine
powershell -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"

:: El script .bat se pausara aqui hasta que el usuario cierre la ventana de PowerShell


:: ---------------------------------------------------
:: 3. SECCION DE LIMPIEZA
:: ---------------------------------------------------
echo "Proceso de activacion finalizado. Limpiando archivos temporales de Office..."

:: 3.1. Borra el instalador
if exist setup.exe (
    del setup.exe
    echo "setup.exe eliminado."
)

:: 3.2. Borra el archivo de configuracion
if exist config.xml (
    del config.xml
    echo "config.xml eliminado."
)

:: 3.3. Borra la carpeta "Office" que descarga el ODT
if exist "Office" (
    rd /s /q "Office"
    echo "Carpeta de instalacion 'Office' eliminada."
)

echo "Limpieza finalizada. Esta ventana se cerrara en 5 segundos..."
timeout /t 5 /nobreak > nul

:: 3.4. Borra el propio script .bat al salir
(goto) 2>nul & del "%~f0"