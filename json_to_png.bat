@echo off
setlocal enabledelayedexpansion

:: Check if the first argument is provided
if "%~1" equ "" (
    echo Error: labelmeのjsonのファイルパスかフォルダパスが必要です
    exit /b
)

set output_image_dir=""
:: Check if the first argument is a file or a folder
if exist "%~1\*" (
    call :process_folder %~1
) else (
    call :process_file %~1
)

:: maskの色変更
echo mask color replace
for /d %%d in (%output_root_dir%\*) do (
    echo "%%d\label.png"
    python replace_black_to_white.py "%%d\label.png" "%%d\label_white.png"
)

exit /b

:process_file
echo process_file
set "file_name=%~n1"
set "output_root_dir=%~dp1"
set "output_root_dir=%output_root_dir:~0,-1%\output"
set "output_image_dir=%output_root_dir%\%file_name%"
echo process_file input: %1
echo process_file output: %output_image_dir%
mkdir %output_root_dir%
labelme_json_to_dataset %1 --out %output_image_dir%
exit /b

:process_folder
echo process_folder
set "output_root_dir=%1\output"
set "processed=0"
mkdir %output_root_dir%

@REM jsonファイル数
set "total=0"
for /f %%a in ('dir /b /a-d "%1\*.json" 2^>nul ^| find /c /v ""') do set "total=%%a"

echo total
@REM ファイル毎の処理
for %%f in ("%1\*.json") do (
    set /a processed+=1
    set "file_name=%%~nf"
    set "output_image_dir=%1\output\!file_name!"
    echo process_folder !processed! of !total! input: %%f, output: !output_image_dir!
    labelme_json_to_dataset %%f --out !output_image_dir!
)
exit /b
