FROM public.ecr.aws/lambda/nodejs:18

WORKDIR /var/task

COPY package.json pnpm-lock.yaml tsconfig.json ./
RUN npm install -g pnpm && pnpm install && pnpm add @types/aws-lambda -D

COPY src/ src/
COPY utils/ utils/

RUN pnpm run build

CMD ["dist/src/index.handler"]
