export async function expectEventually(
  fn: () => any,
  {timeout = 4_000, interval = 200} = {},
) {
  const start = Date.now();

  while (true) {
    try {
      await fn();
      return;
    } catch (error) {
      if (Date.now() - start >= timeout) {
        throw error;
      }
      await new Promise(resolve => setTimeout(resolve, interval));
    }
  }
}

export async function expectEventuallyWithRetry(
  initialResult: any,
  resultProducer: () => any,
  testingFunction: (result: any) => any,
  {timeout = 4_000, interval = 200} = {},
) {
  const start = Date.now();
  let isInitial = true;

  while (true) {
    try {
      let result: any = undefined;
      if (isInitial) {
        result = initialResult;
      } else {
        result = await resultProducer();
      }
      await testingFunction(result);
      return;
    } catch (error) {
      isInitial = false;
      if (Date.now() - start >= timeout) {
        throw error;
      }
      await new Promise(resolve => setTimeout(resolve, interval));
    }
  }
}
