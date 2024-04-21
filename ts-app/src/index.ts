const main = async () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      console.log("Hello Take-chan");
      resolve("Hello World");
    }, 3000);
  });
};

const handler = async (event: any) => {
  await main();

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: `processed successfully`,
    }),
  };
};

module.exports.handler = handler;
