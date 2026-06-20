# S3 Bucket
resource "aws_s3_bucket" "topbooks_bucket" {
  bucket = "topbooks-malvaviscos-bucket"

  tags = merge(local.tags_obligatorios, {
    Name = "topbooks-bucket"
  })
}