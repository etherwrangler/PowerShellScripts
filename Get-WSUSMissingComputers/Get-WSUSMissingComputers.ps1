[CmdletBinding()]
Param(
    [parameter(Mandatory=$True)]
    [alias("Server")]
    $WsusServer,
    [alias("Port")]
    $WsusPort,
    [parameter(Mandatory=$True)]
    [alias("Output")]
    $OutputFile,
    [switch]$SSL
)

Import-Module -Name UpdateServices, ActiveDirectory
    
If ($Null -eq $WsusPort -And $SSL -eq $False) {
    $WsusPort = "8530"
}
else {
    $WsusPort = "8531"
}

If ($SSL) {
    Write-Host "Connecting to WSUS Server....."
    Write-Host "Name: "$WsusServer
    Write-Host "Port: "$WsusPort
    Write-Host "SSL: Yes"
    $WSUSComputers = Get-WsusComputer -UpdateServer ( Get-WsusServer -Name $WsusServer -Port $WsusPort -UseSsl ) | Select-Object FullDomainName
    $WSUSComputerNames = $WSUSComputers.FullDomainName
}
else {
    Write-Host "Connecting to WSUS Server....."
    Write-Host "Name: "$WsusServer
    Write-Host "Port: "$WsusPort
    Write-Host "SSL: No"
    $WSUSComputers = Get-WsusComputer -UpdateServer ( Get-WsusServer -Name $WsusServer -Port $WsusPort ) | Select-Object FullDomainName
    $WSUSComputerNames = $WSUSComputers.FullDomainName
}

$ADComputers = Get-ADComputer -Filter * | Select-Object DNSHostName
$ADComputerNames = $ADComputers.DNSHostName

$ADComputerNames | Where-Object {$WSUSComputerNames -notcontains $_} > $OutputFile