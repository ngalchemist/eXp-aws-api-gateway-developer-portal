sam deploy `
--template-file ./cloudformation/packaged.yaml `
--stack-name "dev-portal" `
--s3-bucket dev-portal-artifax `
--capabilities CAPABILITY_NAMED_IAM `
--parameter-overrides `
DevPortalSiteS3BucketName="exp-dev-portal-static-assets" `
ArtifactsS3BucketName="exp-dev-portal-artifacts" `
CognitoDomainNameOrPrefix="exp" `
StaticAssetRebuildMode=overwrite-content