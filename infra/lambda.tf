resource "aws_ecr_repository" "lambda_repo" {
  name = "lambda-repo"
  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy" {
  name       = "lambda_policy_attachment"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda_practice" {
  function_name = "lambda_practice"
  package_type  = "Image"

  image_uri = "${aws_ecr_repository.lambda_repo.repository_url}:latest"
  role      = aws_iam_role.lambda_exec.arn

  timeout     = 60
  memory_size = 128
}
