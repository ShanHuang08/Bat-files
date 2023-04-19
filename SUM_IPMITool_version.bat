@echo off
echo SMCIPMITOOL version:
cd /d C:\
cd C:\Users\Stephenhuang

if exist SMCIPMITool* (
    echo Folder exist
    cd C:\Users\Stephenhuang\SMCIPMITool*
    SMCIPMITool.exe cmm ver
) else (
    echo Folder doesn't exist
)

echo -------------------------------------------

echo SUM version:
cd C:\Users\Stephenhuang
if exist *.zip (
    echo ZIP exist
    dir /B *.zip
    cd sum*
    sum.exe --version
) else (
    echo Zip doesn't exist
)

pause