@echo off

set test=B 
echo %test% > test.txt
find "A" test.txt > nul
if %errorlevel% equ 0 (
    echo A is found
)
find "B" text.txt > nul
if %errorlevel% equ 0 (
    echo B is found
)
find "C" text.txt > nul
if %errorlevel% equ 0 (
    echo C is found
)
del test.txt

@REM if %var%==a goto x
@REM if %var%==b goto y
@REM if %var%==c goto z

@REM :x
@REM echo a
@REM pause
@REM exit
@REM :y
@REM echo b
@REM pause
@REM exit
@REM :z
@REM echo c
@REM pause
@REM exit


@REM @REM set x=2
@REM @REM set y=3

@REM SET x=2
@REM set y=3
@REM set /a z=x*y
@REM echo x+y
@REM echo %x%+%y%
@REM echo z
@REM echo %z%