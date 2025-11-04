## Instalador Office LTSC 2024

Ejecutar como administrador en el powershell de windows

```
irm https://raw.githubusercontent.com/Carlos-SaulPM/office-ltsc-2024-installer/main/install_office.bat | Out-File "$env:TEMP\install_office.bat"; Start-Process cmd -ArgumentList "/c $env:TEMP\install_office.bat" -Verb RunAs
```
