@echo off
title Server Setup

:: Dynamically set the base directories based on the script location
set "scriptDir=%~dp0"
set "paperDir=%scriptDir%paper.jar"
set "serverBaseDir=%scriptDir%Server"

:: Navigate to the Paper directory
cd "%paperDir%"
if errorlevel 1 (
    echo Failed to access the Paper directory. Exiting...
    pause
    exit /b
)

:: List Paper versions
echo Available Paper versions:
for %%f in (paper-*.jar) do echo %%f

:: Ask the user to choose a Paper version
set "version="
set /p "version=Enter the Paper version you want to use (e.g., paper-1.20.4-499.jar): "

:: Check if the chosen version exists
if not exist "%version%" (
    echo The chosen version does not exist.
    pause
    exit /b
)

:: Ask for the server name
set "serverName="
set /p "serverName=Enter the name for your server: "

:: Create the server folder
set "serverDir=%serverBaseDir%\%serverName%"
mkdir "%serverDir%"
if errorlevel 1 (
    echo Failed to create the server folder. Exiting...
    pause
    exit /b
)

:: Copy the Paper file to the server folder
copy "%version%" "%serverDir%\%version%"
if errorlevel 1 (
    echo Failed to copy the Paper file. Exiting...
    pause
    exit /b
)

:: Ask the user for RAM allocation
set "minRAM="
set "maxRAM="
set /p "minRAM=Enter the minimum RAM for the server (e.g., 1G or 512M): "
set /p "maxRAM=Enter the maximum RAM for the server (e.g., 2G or 1024M): "

:: Generate the run.bat file
(
    echo @echo off
    echo title %serverName% Server Console
    echo java -Xms%minRAM% -Xmx%maxRAM% -jar "%version%" nogui
    echo pause
) > "%serverDir%\run.bat"

:: Completion message
echo Setup complete!
echo Your server is located at "%serverDir%"
echo.

:: Ask if the user wants to run the server
set "runNow="
set /p "runNow=Do you want to start the server now? (Y/N): "
if /i "%runNow%"=="Y" (
    cd /d "%serverDir%"
    start "" run.bat
)

pause
