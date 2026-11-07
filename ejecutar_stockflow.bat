@echo off
title StockFlow - Iniciar Aplicacion
echo ===================================================
echo     Iniciando StockFlow (JavaFX + MySQL / XAMPP)
echo ===================================================

set STOCKFLOW_DB_URL=jdbc:mysql://localhost:3306/stockflow_db?useSSL=false^&serverTimezone=UTC^&allowPublicKeyRetrieval=true
set STOCKFLOW_DB_USER=stockflow_app
set STOCKFLOW_DB_PASSWORD=clave_local

echo.
echo [1/2] Restaurando base de datos a su estado inicial de prueba...
if exist "C:\xampp\mysql\bin\mysql.exe" (
    "C:\xampp\mysql\bin\mysql.exe" -u root < sql\01_create_database.sql
    "C:\xampp\mysql\bin\mysql.exe" -u root < sql\02_create_tables.sql
    "C:\xampp\mysql\bin\mysql.exe" -u root < sql\03_seed_data.sql
    echo     Base de datos restaurada correctamente con el escenario de prueba.
) else (
    echo     [AVISO] No se encontro mysql.exe en C:\xampp\mysql\bin. Se inicia con los datos existentes.
)

echo.
echo [2/2] Compilando y ejecutando la aplicacion StockFlow...
call mvnw.cmd javafx:run

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Ocurrio un problema al iniciar la aplicacion.
    pause
)

