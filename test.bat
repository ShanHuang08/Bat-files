@echo off
echo "If you don't want to update specific FW, please type n"
set /p bmcfile="Plz drag BMC FW file or type (n) "
if /i "%bmcfile%"=="n" (
    set /p biosfile="Plz drag BIOS FW file or type (n) "
) else (
    set biosfile=n
)
set /p Checkuni= "Login via Unique Password (y/n) "

if /i %Checkuni%==y (
    set /p pwd="Input Unique Password: "
) else (
    set pwd=ADMIN  
)
echo bios = %biosfile%
echo pwd = %pwd%