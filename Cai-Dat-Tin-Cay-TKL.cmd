@echo off
setlocal
chcp 65001 >nul
echo ============================================================
echo   CAI DAT CHUNG CHI TIN CAY - TRUNG KIEN LANDSCAPE (TKL)
echo ============================================================
echo.

set "CERT_FILE=%~dp0TKL-Root-CA.cer"
if not exist "%CERT_FILE%" (
    echo [LOI] Khong tim thay tep chung chi: %CERT_FILE%
    if /i not "%~1"=="/silent" pause
    exit /b 1
)

echo [1/3] Dang cai dat chung chi tin cay cho tai khoan hien tai...
certutil.exe -user -addstore Root "%CERT_FILE%" >nul
certutil.exe -user -addstore TrustedPublisher "%CERT_FILE%" >nul

echo [2/3] Dang cai dat chung chi he thong (neu co quyen Administrator)...
certutil.exe -addstore Root "%CERT_FILE%" >nul 2>&1
certutil.exe -addstore TrustedPublisher "%CERT_FILE%" >nul 2>&1

echo [3/3] Dang go bo canh bao Internet (Mark-of-the-Web) cho cac tep TKL...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '%~dp0' -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue; Get-ChildItem -Path '%~dp0..' -Filter '*TKL*' -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue"

echo.
echo [HOAN TAT] Da them chung chi tin cay Trung Kien Landscape (TKL) va mo khoa tep cai dat.
if /i not "%~1"=="/silent" pause
