$service = Get-Service "signalfx-agent" -ErrorAction SilentlyContinue
if ($null -ne $service)
{
    $service | Stop-Service
}
