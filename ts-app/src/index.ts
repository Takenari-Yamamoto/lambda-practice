import { Handler } from "aws-lambda";
import dayjs from "dayjs";
import { funcA } from "../utils/functionA";

const main = async () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      funcA();
      console.log(`Hello Take-chan ${funcA()}`);
      resolve("Hello World");
    }, 3000);
  });
};

export const handler: Handler = async (event: any) => {
  await main();

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: `processed successfully ${dayjs().format(
        "YYYY-MM-DD HH:mm:ss"
      )} ${funcA()}`,
    }),
  };
};
