# Minecraft Server Setup Script

This batch script helps automate the process of setting up and running a PaperMC Minecraft server. The script allows users to easily download the correct PaperMC version, set up the server, and configure it to their preferences, including the RAM allocation.

## Features

- **Automated PaperMC Setup**: Downloads the specified Minecraft version and PaperMC build.
- **Server Directory Creation**: Creates a folder for your new server and stores all necessary files.
- **RAM Configuration**: Lets you configure the minimum and maximum RAM allocation for your server.
- **Run Server**: Option to start the server immediately after setup.
- **Customizable Server Name**: Allows you to name your server whatever you want.

## Requirements

- **Windows Operating System**: This script is designed for Windows environments.
- **Curl**: The script uses `curl` to download PaperMC versions. Make sure `curl` is installed or available in your system's PATH.

## paper.bat - PaperMC Installer

The `paper.bat` file is used to **download** the correct PaperMC version from the internet and place it in your server folder. The script automates the process of fetching the PaperMC server JAR file based on the Minecraft version and build number you provide.

## How to Use

1. **Download the Script**: Download `setup.bat` to your computer.
2. **Run the Script**: Double-click on `setup.bat` to begin the server setup process.
3. **Follow the Prompts**: The script will guide you through selecting the Minecraft version, build number, server name, and RAM allocation.
4. **Start the Server**: After setup, you'll have the option to start the server immediately.

### How it Works:

- **Version and Build Selection**: The script will prompt you to enter the Minecraft version and build number.
- **Downloading PaperMC**: Once the version and build are selected, `paper.bat` uses `curl` to fetch the corresponding PaperMC version.
- **Server Setup**: It will save the downloaded PaperMC server JAR file in your designated folder.
