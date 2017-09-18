$ftpserverport = "ENTERSTRING"
$ftpusername = "ENTERSTRING"
$ftpserveraddress = "ENTERSTRING"
$storename = "ENTERSTRING"
$laname = "ENTERSTRING"

$folderdate = Get-Date -format 'yyyyMMdd'

# Check Azure Files for Date Directory create if not there


$StorageAccountName = 'ENTERSTRING'

$StorageAccountKey = 'ENTERSTRING'

$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

$share = Get-AzureStorageShare -Name "fromccvendor" -Context $ctx

New-AzureStorageDirectory -Share $share -Path $folderdate

$lafolder = "/" + $folderdate

$azufolder = "/fromccvendor/" + $folderdate

$secretvalue = ConvertTo-SecureString "ENTERSTRING" -AsPlainText -Force

$secretpass = ConvertTo-SecureString "ENTERSTRING" -AsPlainText -Force

New-AzureRmResourceGroupDeployment -ResourceGroupName "ENTERRGNAME" -TemplateUri "https://raw.githubusercontent.com/swiftsolves-msft/ftp-loki/master/azuredeploy.json" -logicAppName $laname -azurefileaccountName $storename -azurefileaccessKey $secretvalue -ftpserverAddress $ftpserveraddress -ftpuserName $ftpusername -ftppassword $secretpass -ftpserverPort $ftpserverport -ftpisssl $false -ftpisBinaryTransport $false -ftpdisableCertificateValidation $false -lafolder $lafolder -azufolder $azufolder

