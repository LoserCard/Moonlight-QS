param (
    [parameter(ParameterSetName="MAC", Mandatory=$true)]
    [string]$MAC
)

$MacByteArray = $MAC -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
[Byte[]] $MagicPacket = (,0xFF * 6) + ($MacByteArray  * 16)

try{
    Write-Verbose "Sending WOL packet to MAC $MAC"
    $UdpClient = New-Object System.Net.Sockets.UdpClient
    $UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
    $null = $UdpClient.Send($MagicPacket,$MagicPacket.Length)
    $UdpClient.Close()
}
catch{
    Write-Warning "Error sending WOL packet"
}