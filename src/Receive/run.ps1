using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Interact with query parameters or the body of the request.
$data = $Request.Body | ConvertFrom-Json
$data | Add-Member -Name "id" -MemberType NoteProperty -Value (New-Guid).Guid
Write-Host ($data | Select-Object -Property computerName,userName,profileName | ConvertTo-Json)

Push-OutputBinding -Name "loginsDocument" -Value $data

$body = "This HTTP triggered function executed successfully."

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
