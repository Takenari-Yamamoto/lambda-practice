#!/bin/bash

# NOTE: 実行時には ACCOUNT_ID を設定してください
# export ACCOUNT_ID="123456789012"

# 環境変数の設定
REGION="ap-northeast-1"
REPO_NAME="lambda-repo"
FUNCTION_NAME="lambda_practice"
IMAGE_NAME="lambda-practice"
IMAGE_TAG="latest"

# 必要な環境変数の確認
if [ -z "$ACCOUNT_ID" ]; then
  echo "ACCOUNT_ID is not set."
  exit 1
fi

IMAGE_URI="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}"

# Dockerイメージをビルドする
docker build -t ${IMAGE_NAME} . || { echo "Docker build failed"; exit 1; }

# ECRへのログイン
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com || { echo "Login failed"; exit 1; }

# タグを付ける
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_URI} || { echo "Tagging failed"; exit 1; }

# ECRにプッシュする
docker push ${IMAGE_URI} || { echo "Docker push failed"; exit 1; }

# Lambdaにデプロイする
aws lambda update-function-code --function-name ${FUNCTION_NAME} --image-uri ${IMAGE_URI} || { echo "Lambda deployment failed"; exit 1; }

echo "Deployment successful!"
