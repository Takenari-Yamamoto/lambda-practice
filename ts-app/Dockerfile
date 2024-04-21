FROM public.ecr.aws/lambda/nodejs:20 as builder
WORKDIR /usr/src/app
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm
RUN pnpm install
COPY src ./src
RUN pnpm run build

FROM public.ecr.aws/lambda/nodejs:20
WORKDIR ${LAMBDA_TASK_ROOT}
COPY --from=builder /usr/src/app/dist/src/index.mjs ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
CMD ["index.handler"]
