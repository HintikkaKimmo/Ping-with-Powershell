<#

.SYNOPSIS
  Powershell script to ping all IP addresseses in a CSV file.
  
.DESCRIPTION
  This PowerShell script reads a CSV file and pings all the IP addresses listed in the IPAddress column.

.PARAMETER <csvfile>
   File name and path of the CSV file to read.
.NOTES
  Version:        1.0
  Author:         Kimmo Hintikka
  Creation Date:  03-Mar-2017
 
.LINK
    https://github.com/HintikkaKimmo/Ping-with-Powershell
    
.EXAMPLE
  Ping-IPList c:\ip.csv

#>

Param(
  [Parameter(Mandatory=$true, position=0)][string]$csvfile
)

$ColumnHeader = "IP Address"

Write-Host "Reading file" $csvfile
$ipaddresses = import-csv $csvfile | select-object $ColumnHeader

Write-Host "Started Pinging.."
foreach( $ip in $ipaddresses) {
    if (test-connection $ip.("IPAddress") -count 1 -quiet) {
        write-host $ip.("IPAddress") "Ping succeeded." -foreground green

    } else {
         write-host $ip.("IPAddress") "Ping failed." -foreground red
    }
    
}

Write-Host "Pinging Completed."