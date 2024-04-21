FROM public.ecr.aws/lambda/nodejs:20 as builder

WORKDIR /usr/src/app

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

RUN pnpm install

COPY src ./src

RUN pnpm run build

# 実行ステージ
FROM public.ecr.aws/lambda/nodejs:20

# Lambda の実行ディレクトリに設定
WORKDIR ${LAMBDA_TASK_ROOT}

# ビルドされた JavaScript ファイルをコピー
COPY --from=builder /usr/src/app/dist/src/index.js ./

# Lambda ハンドラの指定
CMD ["index.handler"]
