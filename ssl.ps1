Install-WindowsFeature -Name Web-Server -IncludeManagementTools
@'
<!DOCTYPE html>
<html>
   <head>

		<title>the Internet - a series of tubes</title>
   </head>
   <body>

		<img src="cats.jpg" >

   </body>
</html>
'@ > 'C:\inetpub\wwwroot\Default.htm'


$certificateDnsName = 'my.catcert.ssl' 

$siteName = "Default Web Site" # the website to apply the bindings/cert to (top level, not an application underneath!).
$fqdn = "mycat"                     #fully qualified domain name (empty for 'All unassigned', or e.g 'contoso.com')


# ----------------------------------------------------------------------------------------
# SSL CERTIFICATE CREATION
# ----------------------------------------------------------------------------------------

# create the ssl certificate that will expire in 2 years
$newCert = New-SelfSignedCertificate -DnsName $certificateDnsName -CertStoreLocation cert:\LocalMachine\My -NotAfter (Get-Date).AddYears(2)
"Certificate Details:`r`n`r`n $newCert"


# ----------------------------------------------------------------------------------------
# IIS BINDINGS
# ----------------------------------------------------------------------------------------


$webbindings = Get-WebBinding -Name $siteName
$webbindings


$hasSsl = $webbindings | Where-Object { $_.protocol -like "*https*" }

if($hasSsl)
{
    Write-Output "ERROR: An SSL certificate is already assigned. Please remove it manually before adding this certificate."
    Write-Output "Alternatively, you could just use that certificate (provided it's recent/secure)."
}else
{
    "Applying TLS/SSL Certificate"
    New-WebBinding -Name $siteName -Port 443 -Protocol https -HostHeader $fqdn
    (Get-WebBinding -Name $siteName -Port 443 -Protocol "https" -HostHeader $fqdn).AddSslCertificate($newCert.Thumbprint, "my")

    "`r`n`r`nNew web bindings"
    $webbindings = Get-WebBinding -Name $siteName
    $webbindings
}

Enable-PSRemoting -Force
winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'
netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow
Set-Service winrm -startuptype "auto"
Restart-Service winrm