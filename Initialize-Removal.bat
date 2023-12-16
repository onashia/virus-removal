@echo off

:: Description     > Download and run AdwCleaner and Malwarebytes Toolkit within BeyondTrust Bomgar

:: General Variables
set "key=INSERT_KEY_HERE"
set "folder=C:\STS\Tools\Malwarebytes"

:: AdwCleaner Variables
set "adwApp=adwcleaner.exe"
set "adwFile=adwcleaner.exe"
set "adwUrl=https://adwcleaner.malwarebytes.com/adwcleaner?channel=release"

:: Malwarebytes Variables
set "mwbApp=MBTSLauncher.exe"
set "mwbFile=MBTS.zip"
set "mwbUrl=https://toolset.malwarebytes.com/file/mbts/%key%"

:: Create %folder%
if not exist %folder% ( mkdir %folder% && echo %folder% created)

:: Download AdwCleaner
echo 1. Downloading AdwCleaner
PowerShell -NoProfile -Command "(New-Object Net.WebClient).DownloadFile('%adwUrl%', '%folder%\%adwFile%')"

:: Open and initiate an AdwCleaner Scan
echo 2. Starting AdwCleaner
start %folder%\%adwApp% /eula /noreboot /clean

:: Download Malwarebytes
echo 3. Downloading Malwarebytes
PowerShell -NoProfile -Command "(New-Object Net.WebClient).DownloadFile('%mwbUrl%', '%folder%\%mwbFile%')"