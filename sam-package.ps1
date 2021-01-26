Param (
    [Parameter(Mandatory=$true,
    HelpMessage="Enter bucket name",
    Position=0)]
    [String]
    $BucketName,

    [Parameter(Mandatory=$false,
    HelpMessage="No profile specified. To use the default profile press Enter. Otherwise, enter a profile name",
    Position=1)]
    [AllowEmptyString()]
    [String]
    $AWSProfile
)

$ExistingBucket = aws s3 ls | Where-Object {$_ -like "*$BucketName*"}
if ( $ExistingBucket ) {
    Write-Output 'Bucket already exists'
} else {
    Write-Output 'Creating bucket...'
    aws s3 mb "s3://$BucketName"
}

if ($AWSProfile -eq $null -or $AWSProfile -eq "") {
    Write-Host Sam package output:
    sam package --template-file ./cloudformation/template.yaml `
    --output-template-file ./cloudformation/packaged.yaml `
    --s3-bucket $BucketName `
} else {
    sam package --template-file ./cloudformation/template.yaml `
    --output-template-file ./cloudformation/packaged.yaml `
    --s3-bucket $BucketName `
    --profile $AWSProfile
}