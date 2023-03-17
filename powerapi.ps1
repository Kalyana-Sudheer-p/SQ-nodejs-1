$token = [System.Text.Encoding]::UTF8.GetBytes("squ_00cee7cb826eb3c74e1488e303cd221cd36c1048" + ":")
$base64 = [System.Convert]::ToBase64String($token)
 
$basicAuth = [string]::Format("Basic {0}", $base64)
$headers = @{ Authorization = $basicAuth }
 
$result = Invoke-RestMethod -Method Get -Uri http://localhost:9000/api/qualitygates/project_status?projectKey=Sample_Test_Sample_Test_AYbk2tgYBLZgUKemSz15 -Headers $headers
$result | ConvertTo-Json | Write-Host
 
if ($result.projectStatus.status -eq "OK") {
Write-Host "Quality Gate Succeeded"
}else{
    Write-Host "Quality Gate failed. Stopping Azure Classic Pipeline."
    Write-Error "Quality Gate failed"
    exit 1
    
}