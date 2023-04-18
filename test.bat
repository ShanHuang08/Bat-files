@echo off
@REM https://hackmd.io/@peterju/B1pUqd-5c
set FolderPath=C:\Users\Shan\Workspace2\Bat-files
set ip=127.0.0.1
set filename=%ip%_ping.txt
date /t > %FolderPath%\%filename%
time /t >> %FolderPath%\%filename%

echo 123132132 >> %FolderPath%\%filename%
echo tset >> %FolderPath%\%filename%
echo ------------------------ >> %FolderPath%\%filename%

ping %ip% >> %FolderPath%\%filename%

dir >> %FolderPath%\%filename%
cd C:\

dir >> %FolderPath%\%filename%
start %FolderPath%\%filename%
