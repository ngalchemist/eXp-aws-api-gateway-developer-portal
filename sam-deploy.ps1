Param (
    [Parameter(Mandatory=$true,
    HelpMessage="Enter bucket name",
    Position=0)]
    [String]
    $BucketName
)

$ExistingBucket = aws s3 ls | Where-Object {$_ -like "*$BucketName*"}
if ($ExistingBucket -eq $null) {
    Write-Output "Bucket $BucketName doesn't exists yet. Run the sam deploy ps script first."
    exit
}

Write-Host 'sam deploy output:'
sam deploy --template-file ./cloudformation/template.yaml `
--stack-name "dev-portal" `
--s3-bucket $BucketName `
--capabilities CAPABILITY_NAMED_IAM `
--parameter-overrides `
DevPortalSiteS3BucketName="exp-dev-portal-static-assets" `
ArtifactsS3BucketName="exp-dev-portal-artifacts" `
CognitoDomainNameOrPrefix="exp"