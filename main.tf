# Generate a random suffix so bucket names are unique
resource "random_id" "suffix" {
  byte_length = 4
}

# Create S3 bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = "innovatemart-test-bucket-${random_id.suffix.hex}"
}

# Configure the bucket as a website
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = "../website/index.html"
  content_type = "text/html"
  acl          = "public-read"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "error.html"
  source       = "../website/error.html"
  content_type = "text/html"
  acl          = "public-read"
}


