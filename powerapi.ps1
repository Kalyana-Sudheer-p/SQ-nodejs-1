$token = [System.Text.Encoding]::UTF8.GetBytes("sqa_caf595c25073636e28f81daa8e83eab5b72f9513" + ":")
$base64 = [System.Convert]::ToBase64String($token)
 
$basicAuth = [string]::Format("Basic {0}", $base64)
$headers = @{ Authorization = $basicAuth }
 
$result = Invoke-RestMethod -Method Get -Uri http://20.235.79.55:9000/api/qualitygates/project_status?projectKey=Demo-Project_Demo-Repo_AYbqyao38zymFYv_hZQG -Headers $headers
$result | ConvertTo-Json | Write-Host
 
if ($result.projectStatus.status -eq "OK") {
Write-Host "Quality Gate Succeeded"
}else{
    Write-Host "Quality Gate failed. Stopping Azure Classic Pipeline."
    Write-Error "Quality Gate failed"
    exit 1
    
}