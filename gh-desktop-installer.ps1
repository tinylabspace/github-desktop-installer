# created by Travis Johnson have fun!
# https://github.com/tinylabspace

# accept a download path paramater or simply put it in the users downloads directory
# usage .\gh-desktop-installer.ps1 -downloadpath "C:\tools"

param (
         [string]$downloadpath = "$($env:USERPROFILE)\downloads"
     )

# Check if the OS is Windows, if not quit
if ($env:OS -notlike '*Windows*')
{
    Write-Host "This script is designed to run on Windows, you can download GitHub Desktop on your OS from https://desktop.github.com/. Exiting..."
    exit
}

$DownloadUrl = "https://central.github.com/deployments/desktop/desktop/latest/win32"
$DownloadPath = "$($downloadpath)\GitHubDesktopSetup-x64.exe"
$InstallPath = "$env:USERPROFILE\AppData\Local\GitHubDesktop\GitHubDesktop.exe"

# hide the download progress to speed things up
$ProgressPreference = 'SilentlyContinue'

# Check if the download path exists, and create it if it doesn't
if (-not (Test-Path -Path $DownloadPath))
{
    Write-Host "Creating download path..."
    New-Item -ItemType Directory -Force -Path (Split-Path -Path $DownloadPath)
}

# Download the latest version of GitHub Desktop
Invoke-WebRequest -Uri $DownloadUrl -OutFile $DownloadPath

# Execute the installer and wait for the processes to finish
Start-Process -FilePath $DownloadPath -Wait

# Wait for the installer to complete
Write-Host "Waiting for GitHub Desktop installation to complete..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Start GitHub Desktop
Start-Process -FilePath $InstallPath
Write-Host "GitHub Desktop is installed and should be running!" -ForegroundColor Green

# delete the download
write-host "Deleting the download" -ForegroundColor Green
Remove-Item -Path $DownloadPath