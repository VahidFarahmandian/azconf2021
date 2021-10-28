Param(
    [String] 
    $elasticUrl="",
    [String] 
    $elasticUsername,
    [String] 
    $elasticPassword
)
    $indexName = 'azconf'
    $elasticUrl = $elasticUrl+'/'+$indexName
    $headers = @{
        'Authorization' = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($elasticUsername):$($elasticPassword)"))
    }
    try{
        Invoke-RestMethod -Method Get -Headers $headers -Uri $elasticUrl
    }
    catch{
        if($_.Exception.Response.StatusCode.value__ -ge 300){
            Invoke-RestMethod -Method Put -Headers $headers -Uri $elasticUrl
        }
    }
    $elasticUrl = $elasticUrl+'/_doc'
    $data = @{ 
                id = 1
                name = "vahid"
            }
    $jsonData = ConvertTo-Json $data -Compress    
    Invoke-RestMethod -Method Post -Headers $headers -Uri $elasticUrl -Body $jsonData -ContentType 'application/json; charset=utf-8' 