@echo off

rem Read configuration from config.txt for other parameters
for /f "tokens=1,* delims==" %%A in (config.txt) do (
    if "%%A"=="MAX_RETRIES" set "MAX_RETRIES=%%B"
    if "%%A"=="MOONLIGHT_PATH" set "MOONLIGHT_PATH=%%~B"
)

rem Get MAC, IP, HOST, and APP from command line arguments
set "MAC=%1"
set "IP=%2"
set "HOST=%3"
set "APP=%4"

rem Check if MAC, IP, HOST, and APP are provided
if "%MAC%"=="" (
    echo MAC address is not provided.
    exit /b 1
)
if "%IP%"=="" (
    echo IP address is not provided.
    exit /b 1
)
if "%HOST%"=="" (
    echo Hostname is not provided.
    exit /b 1
)
if "%APP%"=="" (
    echo Application is not provided.
    exit /b 1
)

rem Display the splash screen
start "" /B .\Scripts\splash.hta

rem Run the PowerShell script with the predefined MAC address
PowerShell -ExecutionPolicy Bypass -Command ".\Scripts\wol.ps1 -MAC '%MAC%'"

rem Initialize counter
set "counter=1"

rem Wait until the target computer responds to ping or loop repeats maximum defined times
:pingloop
ping -n 1 %IP% >nul
if errorlevel 1 (
    echo Waiting for the host computer to respond... Attempt #%counter%
    set /a counter+=1
    if %counter% leq %MAX_RETRIES% (
        goto pingloop
    ) else (
        rem Display a self-expiring message window
        powershell -Command "(New-Object -ComObject WScript.Shell).Popup('The host computer did not respond. Please check the host computer''s network connection and try again.', 10, 'Message', 48)"
        rem Kill the splash.hta window
        powershell -Command "Stop-Process -Name mshta -Force -ErrorAction SilentlyContinue -ErrorVariable ProcessNotFound | Where-Object { $_.MainWindowTitle -like 'MoonlightSplash' }"
        exit /b 1
    )
) else (
    echo Host computer is now online.
    rem Add further actions here

    rem Kill the splash.hta window
    powershell -Command "Stop-Process -Name mshta -Force -ErrorAction SilentlyContinue -ErrorVariable ProcessNotFound | Where-Object { $_.MainWindowTitle -like 'MoonlightSplash' }"

    rem Run Moonlight Game Streaming
    start "" "%MOONLIGHT_PATH%" stream "%HOST%" "%APP%"
)