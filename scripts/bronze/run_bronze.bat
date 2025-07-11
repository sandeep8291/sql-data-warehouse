@echo off
REM ===============================
REM Batch Script to Load Bronze Layer in PostgreSQL
REM Uses psql to execute your SQL file with \COPY commands
REM ===============================

echo Starting bronze layer load using PSQL...

REM --- Set your database credentials and path here ---
SET PGPASSWORD= ex.12345679
psql -U postgres -d datawarehouse -h localhost < your_sql_file_path

echo.
echo Load complete. Press any key to exit.
pause
