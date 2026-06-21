resource "aws_s3_bucket" "topbooks_bucket" {
  bucket = "topbooks-${var.group_name}-bucket"

  tags = merge(local.common_tags, {
    Name = "topbooks-bucket"
  })
}
