
terraform {
    backend "s3" {
        region = "us-east-1"
        bucket = "ayoub-s3-demo-bucket"
        key = "backend/aws-two-tier.tfstate"
        dynamodb_table = "dynamo-demo"
        use_lockfile = true
        
    }
  
}