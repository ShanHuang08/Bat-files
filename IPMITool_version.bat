@echo off
cd C:\Users\Stephenhuang

if exist SMCIPMITool (
    echo Folder exist
) else (
    echo Folder doesn't exist
)

cd C:\Users\Stephenhuang\SMCIPMITool
SMCIPMITool.exe cmm ver
pause