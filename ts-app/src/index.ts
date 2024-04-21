const main = async () => {
  return new Promise((resolve) => {
    resolve("Hello World");
  });
};

const handler = async (event: any) => {
  await main();

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "success to process event",
    }),
  };
};

module.exports.handler = handler;
