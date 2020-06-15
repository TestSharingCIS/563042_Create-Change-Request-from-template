try{
    # Eg. User name="admin", Password="admin" for this code sample.
    $user = "admin"
    $pass = "Wipro@123"

    # Build auth header
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $pass)))

    # Set proper headers
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('Authorization',('Basic {0}' -f $base64AuthInfo))
    $headers.Add('Accept','application/json')
    $headers.Add('tableName','change_request’)
    $headers.Add('templateName','VM Provisioning’)

    #Instance Name
    $instnace_name = "https://dev50379.service-now.com"

    # Specify endpoint uri
    $uri = "$instnace_name/api/wipli/record_from_template"

    # Specify HTTP method
    $method = "post"
    
    #{request.body ? "$body = \"" :""}}

    # Send HTTP request
    $response = Invoke-WebRequest -Headers $headers -Method $method -Uri $uri -ContentType 'application/json' -Body $body -ErrorAction SilentlyContinue

    # Print response
    $content = $response.Content | ConvertFrom-Json
    $record_sys_id = $content.result.record_sys_id
    $record_sys_id 
     Start-Sleep 20
   
    # Specify endpoint uri
    $uri_update = "$instnace_name/api/now/table/change_request/$record_sys_id"

    # Specify HTTP method
    $method_update = "patch"

    # Specify request body
    $body = "{""short_description"":""test"",""description"":""this is only testing""}"

    # Send HTTP request
    $response_update = Invoke-WebRequest -Headers $headers -Method $method_update -Uri $uri_update -Body $body -ContentType 'application/json' #-Credential (Get-Credential)

    # Print response
    $update_content = $response_update.Content | ConvertFrom-Json
    $update_content.result.number


}
catch{
    $_
}