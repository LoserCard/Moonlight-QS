REM Enable delayed expansion
setlocal enabledelayedexpansion

REM Check if the Shortcuts directory exists, if not, create it
if not exist "Shortcuts" (
    mkdir "Shortcuts"
)

REM Loop through each line in shortcuts.txt
for /f "usebackq tokens=1-4 delims=," %%a in ("shortcuts.txt") do (
    REM Check if the first token is not a semicolon
    if not "%%a"==";" (
        REM Print the extracted parameters for debugging
        echo MAC: %%a
        echo IP: %%b
        echo HOST: %%c
        echo APP: %%d
        echo.

        REM Create the shortcut
        set "shortcut_name=%%d (%%c)"
        set "target_path=.\Scripts\quickstart.vbs %%a %%b %%c %%d"
        set "shortcut_path=Shortcuts\!shortcut_name!.lnk"
        echo Creating shortcut: !shortcut_path!
        
        REM Run VBScript passing shortcut name and other parameters
        cscript //nologo .\Scripts\createShortcut.vbs "!shortcut_path!" "%cd%\Scripts\quickstart.vbs" "%%a" "%%b" "%%c" "%%d"

        REM Check if creating shortcut was successful
        if exist "!shortcut_path!" (
            echo Shortcut created successfully: !shortcut_path!
        ) else (
            echo Failed to create shortcut: !shortcut_path!
        )
    )
)

REM End delayed expansion
endlocal
