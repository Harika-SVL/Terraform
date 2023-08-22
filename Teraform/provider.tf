provider "aws" {
    access_key = "AKIAYGBCZFGIO3ZUNEQW"
    secret_key = "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"
    region = "ap-south-2"
}

resource "aws_s3_bucket" "first" {
    bucket = "terraform_bucket"
}