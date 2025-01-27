@echo off
title PaperMC Server Setup

:: Enable ANSI escape codes for colors
cls
echo.

:: Display "Itz0Cat" in big letters with cyan color
echo [36m
echo  _____ _        ___   _____      _   
echo |_   _| |      / _ \ / ____|    | |  
echo   | | | |_ ___| | | | |     __ _| |_ 
echo   | | | __|_  / | | | |    / _` | __|
echo  _| |_| |_ / /| |_| | |___| (_| | |_ 
echo |_____|\__/___|\___/ \_____\__,_|\__|
                                      
                                       
echo.
echo Join my Discord server: https://dsc.gg/itz0cat
echo.

:: Open a browser tab with the link
start https://dsc.gg/itz0cat

:: Dynamically set the base directories based on the script location
set "scriptDir=%~dp0"
set "paperDir=%scriptDir%PaperMC Files"
set "serverBaseDir=%scriptDir%Server"

:: Check if the PaperMC Files folder exists, if not, notify user and exit
if not exist "%paperDir%" (
    echo PaperMC files are missing! Please run install-papermc.bat first.
    pause
    exit /b
)

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
    echo The chosen version does not exist. Please ensure the file is in the PaperMC Files folder.
    pause
    exit /b
)

:: Ask for the server name
set "serverName="
set /p "serverName=Enter the name for your server (e.g., MyMinecraftServer): "

:: Create the server folder if it doesn't exist
set "serverDir=%serverBaseDir%\%serverName%"
if not exist "%serverDir%" (
    echo Creating server folder: %serverDir%
    mkdir "%serverDir%"
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
echo Server setup complete!
echo Your server is located at: "%serverDir%"
echo You can now run the server using the run.bat file.

:: Ask if the user wants to run the server immediately
set "runNow="
set /p "runNow=Do you want to start the server now? (Y/N): "
if /i "%runNow%"=="Y" (
    cd /d "%serverDir%"
    start "" run.bat
)

pause
