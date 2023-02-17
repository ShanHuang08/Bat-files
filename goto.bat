@echo off

set var=b

if %var%==a goto x
if %var%==b goto y
if %var%==c goto z

:x
echo a
pause
exit
:y
echo b
pause
exit
:z
echo c
pause
exit


@REM set x=2
@REM set y=3

SET x=2
set y=3
set /a z=x*y
echo x+y
echo %x%+%y%
echo z
echo %z%