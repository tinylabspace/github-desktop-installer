# accept a download path paramater or simply put it in the users downloads directory
param (
         [string]$downloadpath = "$($env:USERPROFILE)\downloads"
     )

$DownloadUrl = "https://central.github.com/deployments/desktop/desktop/latest/win32"
$DownloadPath = "$($downloadpath)\GitHubDesktopSetup.exe"
$InstallPath = "$env:USERPROFILE\AppData\Local\GitHubDesktop\GitHubDesktop.exe"

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
