# AWSが提供するNode.js 20のLambda対応イメージを使用
# REF: https://github.com/aws/aws-lambda-base-images/blob/nodejs20.x/Dockerfile.nodejs20.x
FROM public.ecr.aws/lambda/nodejs:20

# ------ LAMBDA_TASK_ROOTとは ------
# AWS Lambda 環境での環境変数の1つ。
# Lambda 関数のコードが配置されるディレクトリのパスが格納される。
COPY src/index.js ${LAMBDA_TASK_ROOT}

# LAMBDA_TASK_ROOTの内のファイルを実行する
CMD [ "index.handler" ]