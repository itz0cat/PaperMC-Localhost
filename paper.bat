@echo off
:: Set variables
set "output_folder=paper.jar"
set "base_url=https://api.papermc.io/v2/projects/paper"

:: Check if the output folder exists; if not, create it
if not exist "%output_folder%" (
    mkdir "%output_folder%"
)

:: Prompt the user to select a Minecraft version
echo.
echo Select the Minecraft version you want to install:
for /f %%v in ('curl -s "%base_url%" ^| findstr "versions"') do (
    echo %%v
)
set /p mc_version=Enter Minecraft version (e.g., 1.20.1):

:: Check if the entered version is valid
curl -s "%base_url%/versions/%mc_version%" | findstr "Not Found" >nul
if %errorlevel% equ 0 (
    echo Invalid Minecraft version. Please try again.
    pause
    exit /b
)

:: Prompt the user to select a build
echo.
echo Fetching available builds for Minecraft version %mc_version%...
curl -s "%base_url%/versions/%mc_version%" | findstr "builds" > temp_builds.txt
for /f %%b in (temp_builds.txt) do (
    echo %%b
)
del temp_builds.txt
set /p build_number=Enter build number (e.g., latest):

:: Download the selected version and build
set "download_url=%base_url%/versions/%mc_version%/builds/%build_number%/downloads/paper-%mc_version%-%build_number%.jar"
echo Downloading PaperMC build %build_number% for version %mc_version%...
curl -o "%output_folder%\paper-%mc_version%-%build_number%.jar" "%download_url%"

:: Verify download
if exist "%output_folder%\paper-%mc_version%-%build_number%.jar" (
    echo Download successful! File saved to "%output_folder%".
) else (
    echo Download failed. Please check your internet connection or input values.
)

pause
