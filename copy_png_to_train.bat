@echo off
setlocal enabledelayedexpansion

:: Check if the first argument is provided
if "%~1" equ "" (
    echo Error: labelme�̉摜���i�[���ꂽ�p�X���K�v�ł��B
    exit /b
)

if "%~2" equ "" (
    echo Error: �R�s�[��̃t�H���_�p�X���K�v�ł��B
    exit /b
)

set "copy_root_dir=%~1"
set "output_root_dir=%~2"

for /d %%d in (%output_root_dir%\*) do (
    set "folder_name=%%~nxd"
    echo F | xcopy /y "%%d\img.png" "%copy_root_dir%\abnormal\!folder_name!.png"

    :: �t�@�C�������݂��邩�ǂ������`�F�b�N
    if exist "%%d\label_white.png" (
        echo F | xcopy /y "%%d\label_white.png" "%copy_root_dir%\mask\!folder_name!_mask.png"
    ) else (
        echo F | xcopy /y "%%d\label.png" "%copy_root_dir%\mask\!folder_name!_mask.png"
    )
)

exit /b
