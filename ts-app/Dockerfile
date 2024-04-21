# ビルドステージ
FROM public.ecr.aws/lambda/nodejs:18 as builder

# 作業ディレクトリを設定
WORKDIR /usr/src/app

# package.json と pnpm-lock.yaml をコピー
COPY package.json pnpm-lock.yaml ./

# 依存関係のインストール
RUN npm install

# TypeScript ソースファイルをコピー
COPY src ./src

# TypeScript を JavaScript にトランスパイル
RUN npm run build

# 実行ステージ
FROM public.ecr.aws/lambda/nodejs:18

# Lambda の実行ディレクトリに設定
WORKDIR ${LAMBDA_TASK_ROOT}

# ビルドされた JavaScript ファイルをコピー
COPY --from=builder /usr/src/app/dist/src/index.js ./

# Lambda ハンドラの指定
CMD ["index.handler"]
