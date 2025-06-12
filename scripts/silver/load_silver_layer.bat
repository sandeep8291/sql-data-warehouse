@echo off
REM ==========================================
REM Run Silver Layer Load Procedure via PSQL
REM ==========================================

SET PGPASSWORD=12345678

psql -U postgres -d datawarehouse -h localhost -c "CALL silver.load_silver_layer();"

echo.
echo Silver Layer ETL Completed Successfully.
pause
