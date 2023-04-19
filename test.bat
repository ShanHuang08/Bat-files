
cd
set SMC_Parent=D:\Users\Stephenhuang
echo %SMC_Parent% | findstr /C:"C:" > nul

if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd


