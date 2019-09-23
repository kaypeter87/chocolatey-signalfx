$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destinationDir = "$($env:ProgramFiles)\SignalFx"
$configDir = "$($env:ProgramData)\SignalFxAgent"

if(!(Test-Path -Path $destinationDir))
{
  New-Item -ItemType directory -Path $destinationDir | Out-Null
}
if(!(Test-Path -Path $configDir))
{
  New-Item -ItemType directory -Path $configDir | Out-Null
}

Expand-Archive -Path "$toolsDir\SignalFxAgent-4.10.0-win64.zip" -DestinationPath "$destinationDir\"

if ($null -eq $service)
{
  $installArgs = '-service "install" -logEvents -config C:\ProgramData\SignalFx\agent.yaml'
  Start-Process -FilePath "$destinationDir\SignalFxAgent\bin\signalfx-agent.exe" -ArgumentList $installArgs -NoNewWindow
  Start-Sleep -Seconds 2
  $serviceArgs = '-service "start"'
  Start-Process -FilePath "$destinationDir\SignalFxAgent\bin\signalfx-agent.exe" -ArgumentList $serviceArgs -NoNewWindow
}

