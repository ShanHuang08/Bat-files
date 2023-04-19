@echo off
setlocal enabledelayedexpansion

rem 設定待搜尋的字串
set search_string=1.2.3.4 A12

rem 判斷字串是否包含 "A12"
echo %search_string% | findstr /C:"A12" >nul
if %errorlevel% equ 0 (
    echo "A12 Found"
)

rem 判斷字串是否包含 "B13"
echo %search_string% | findstr /C:"B13" >nul
if %errorlevel% equ 0 (
    echo "B13 Found"
)

rem 如果都沒有找到，則輸出 "沒有找到字串"
if not %errorlevel% equ 0 (
    echo "沒有找到字串"
)

endlocal






@REM set /p ip="ip: "
rem 執行 ping 命令
@REM ping %ip% > ping_result.txt

rem 使用 find 命令搜尋包含 "TTL=" 的行
@REM > nul 是用來將 find 命令的輸出定向到 nul，即不在屏幕上顯示，也不會寫入任何檔案。
@REM find "TTL=" ping_result.txt > nul

@REM echo errorlevel=%errorlevel%

rem 檢查 find 命令的返回值，判斷是否有找到該字串
@REM errorlevel 是一個預設的系統變數，用於表示先前執行的命令是否成功完成。這個變數的值會隨著命令的執行結果而改變，如果命令成功完成，則 errorlevel 的值為 0，否則為非零值。
@REM if %errorlevel% equ 0 (
@REM     echo "TTL=" found in ping result.
@REM ) else (
@REM     echo "TTL=" not found in ping result.
@REM )

rem 刪除暫存的 ping 結果檔案
@REM del ping_result.txt
pause