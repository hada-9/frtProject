$predictionUrl="https://mcog.cognitiveservices.azure.com/customvision/v3.0/Prediction/eb16385b-0930-4a70-83c2-96ac989d1df4/detect/iterations/Iteration1/url"
$predictionKey = "b0c24948eecd4f3dbaa7543735c45a2c"

# Code to call Custom Vision service for image detection

$img = "https://thumbs.dreamstime.com/z/recyclable-waste-resources-clean-glass-paper-plastic-metal-white-background-copyspace-text-recycling-reuse-garb-115897460.jpg"

$headers = @{}
$headers.Add( "Prediction-Key", $predictionKey )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri $predictionUrl `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$prediction = $result | ConvertFrom-Json

$items = $prediction.predictions

foreach ($item in $items) 
{if ($item.probability -gt .9)
{
    Write-Host ("`n",$item.tagName, "`n")
}
}

