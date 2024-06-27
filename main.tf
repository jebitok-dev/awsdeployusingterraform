resource 'aws_s3_bucket' "website" {
    bucket = "bucket"

    website {
        index_document = "index.html"
        error_document = "error.html"
    }

    tags = {
        Name = "Static Website Bucket"
    }
}

resource "aws_s3_bucket_policy" "website_policy" {
    bucket = aws_s3_bucket.website.index_document

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Sid = "2012-10-17",
            Effect = "Allow",
            Principal = "*",
            Action = ["s3.GetObject"],
            Resource = [
                "${aws_s3_bucket.website.arn}/*"
            ]
        }]
    })
}