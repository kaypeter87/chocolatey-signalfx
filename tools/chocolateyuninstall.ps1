$ErrorActionPreference = 'Stop'; # stop on all errors

# Specify install/config path
$destinationDir = "$($env:ProgramFiles)\SignalFx"
$configDir = "$($env:ProgramData)\SignalFxAgent"

$service = Get-Service "signalfx-agent" -ErrorAction SilentlyContinue

# Use agent binary arguments to uninstall
if ($null -ne $service)
{
  $uninstallArgs = '-service "uninstall"'
  Start-Process -FilePath "$destinationDir\SignalFxAgent\bin\signalfx-agent.exe" -ArgumentList $uninstallArgs -NoNewWindow
}

# Clean up directories
Remove-Item -Recurse -Force -Path $destinationDir
Remove-Item -Recurse -Force -Path $configDir
