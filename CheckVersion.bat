@echo off
echo Please chech your SMCIPMITooland sum parent folder path are correct before executing this file.
echo Incorrect folder path will result failed execution with error message.
echo --------------------------------------------------------

set FolderPath=C:\Users\Stephenhuang\Downloads
set SMC_Parent=C:\Users\Stephenhuang
set sum_Parent=C:\Users\Stephenhuang
set /p ip="BMC ip: "
set /p Checkuni="Need Unique Password? (y/n) "
if /i %Checkuni%==y (
    set /p pwd="Unique Password: "
) else (
    set pwd=ADMIN
)

REM 檢查IP是否有效
ping %ip% > ping_result.txt
find "TTL=" ping_result.txt > nul
if %errorlevel% equ 0 (
    echo %ip% is valid ip
    del ping_result.txt
) else (
    echo %ip% is ivalid ip
    del ping_result.txt
    pause
    goto :eof 
)

set filename=%ip%_CheckVersion.txt
cd /d C:\
cd %sum_Parent%\sum*
echo BIOS info > %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbiosinfo --showall >> %FolderPath%\%filename%
echo BMC info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getbmcinfo >> %FolderPath%\%filename%
echo CPLD info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getcpldinfo >> %FolderPath%\%filename%
echo DMI info >> %FolderPath%\%filename%
echo -------------------------------------------------------------------------------- >> %FolderPath%\%filename%
sum.exe -i %ip% -u ADMIN -p %pwd% -c getdmiinfo >> %FolderPath%\%filename%

cd %SMC_Parent%\SMCIPMITool*
echo Redfish version: >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% redfish version >> %FolderPath%\%filename%

start %FolderPath%
start %FolderPath%\%filename%

@REM checkassetinfo
@REM getnvmeinfo
@REM getpsuinfo
@REM getaocnicinfo
