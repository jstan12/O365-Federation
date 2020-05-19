# Your domain
$dom = "example.org"
# Entity ID
$uri = ""
# Duo Single Sign-On URL
$url = ""
# Duo Single Log-Out URL
$logoutUrl = ""
# Add certificate path downloaded from Duo
$cert=New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("C:\Office 365.crt")
$certData = [system.convert]::tobase64string($cert.rawdata)

# Connect to O365 as global admin
Connect-MsolService
# Federate to Duo SSO
Set-MsolDomainAuthentication –DomainName $dom -Authentication Federated -PassiveLogOnUri $url -IssuerUri $uri -LogOffUri $logoutUrl -PreferredAuthenticationProtocol SAMLP -SigningCertificate $certData

# Confirm Federation
Get-MSOLDomain -Domain $dom

# Unfederate O365 from SSO
# Set-MsolDomainAuthentication –DomainName $dom -Authentication Managed
