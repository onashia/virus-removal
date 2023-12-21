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
set "mwbSettings=INSERT_SETTINGS_LINK_HERE"

:: Create %folder%
if not exist %folder% ( mkdir %folder% && echo %folder% created)

:: Run disk cleanup with all options checked
echo 1. Performing disk cleanup
cleanmgr /d c: /verylowdisk

:: Download AdwCleaner
echo 2. Downloading AdwCleaner
PowerShell -NoProfile -Command "(New-Object Net.WebClient).DownloadFile('%adwUrl%', '%folder%\%adwFile%')"

:: Open and initiate an AdwCleaner scan
echo 3. Starting AdwCleaner
start %folder%\%adwApp% /eula /noreboot /clean

:: Download Malwarebytes
echo 4. Downloading Malwarebytes
PowerShell -NoProfile -Command "(New-Object Net.WebClient).DownloadFile('%mwbUrl%', '%folder%\%mwbFile%')"

:: Extract the compressed Malwarebytes file
echo 5. Extracting Malwarebytes
PowerShell -Command "Expand-Archive -LiteralPath '%folder%\%mwbFile%' -DestinationPath '%folder%'" >nul

echo 6. Applying Malwarebytes settings
PowerShell -NoProfile -Command "(New-Object Net.WebClient).DownloadFile('%mwbSettings%', '%folder%\Malwarebytes\MBTS\Data\Configuration\mbts-settings.json')"

:: Open an initiate a Malwarebytes scan
echo 7. Starting Malwarebytes
start %folder%\%MwbApp% /scan:issues
start %folder%\%MwbApp% /scan:malware

:: Open Windows Update window for updates
echo 8. Opening Windows Update
start ms-settings:windowsupdate