@echo off
echo Please chech your SMCIPMITool and sum parent folder path are correct before executing this file.
echo Incorrect folder path will result failed execution with error message.
echo --------------------------------------------------------------------------

set FolderPath=C:\Users\Stephenhuang\Downloads
set SMC_Parent=C:\Users\Stephenhuang\SMCIPMITool_2.27.2_build.230111_bundleJRE_Windows
set sum_Parent=C:\Users\Stephenhuang\sum_2.10.0-p6_Win_x86_64
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
    echo %ip% is invalid ip
    del ping_result.txt
    pause
    goto :eof 
)

rem 檢查資料夾

echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%
if exist %SMC_Parent% (
    rem do nothing
) else (
    echo SMCIPMITool folder doesn't exist
    echo SMC Parent Path=%SMC_Parent%
    pause
    goto :eof
)

echo %sum_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %sum_Parent%
if exist %sum_Parent% (
    rem do nothing
) else (
    echo sum folder doesn't exist
    echo sum Parent Path=%sum_Parent%
    pause
    goto :eof
)

REM 檢查是否要用Unique Password
echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%
SMCIPMITOOL.exe %ip% ADMIN %pwd% user list 2 > Login_Message.txt 
find "Can't login to" Login_Message.txt > nul
if not %errorlevel% equ 0 (
    del Login_Message.txt 
) else (
    echo Use %pwd% login failed
    if /i %Checkuni%==n (
        set /p pwd="Input Unique Password: "
        pause
    ) else (
        set pwd=ADMIN
    )
    del Login_Message.txt
)


set filename=%ip%_CheckVersion.txt

echo %sum_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %sum_Parent%
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

echo %SMC_Parent% | findstr /C:"C:" > nul
if %errorlevel% equ 0 (
    cd /d C:\
) else (
    cd /d D:\
)
cd %SMC_Parent%
echo Redfish version: >> %FolderPath%\%filename%
SMCIPMITool.exe %ip% ADMIN %pwd% redfish version >> %FolderPath%\%filename%


start %FolderPath%
start %FolderPath%\%filename%

@REM checkassetinfo
@REM getnvmeinfo
@REM getpsuinfo
@REM getaocnicinfo
