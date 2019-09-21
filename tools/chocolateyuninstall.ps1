$ErrorActionPreference = 'Stop'; # stop on all errors

$destinationDir = "$($env:ProgramFiles)\SignalFx"
$configDir = "$($env:ProgramData)\SignalFxAgent"

$service = Get-Service "signalfx-agent" -ErrorAction SilentlyContinue

if ($null -ne $service)
{
  $service | Stop-Service
  $uninstallArgs = '-service "uninstall"'
  Start-Process -FilePath "$destinationDir\SignalFxAgent\bin\signalfx-agent.exe" -ArgumentList $uninstallArgs -NoNewWindow
}

Remove-Item -Recurse -Force -Path $destinationDir
Remove-Item -Recurse -Force -Path $configDir
