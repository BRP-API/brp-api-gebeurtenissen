import {createLogger, format, transports, Logger} from 'winston';

function createWinstonLogger(logLevel: string): Logger {
  return createLogger({
    level: logLevel,
    transports: [
      new transports.Console({
        format: format.prettyPrint(),
      }),
    ],
  });
}

const loggerInstance: Logger = createWinstonLogger('warn');

export function setupLogger(logLevel: string): void {
  loggerInstance.level = logLevel;
  if (logLevel === 'debug') {
    enableFetchLogging();
  }
}

export const logger = loggerInstance;

const originalFetch = globalThis.fetch;

function enableFetchLogging() {
  globalThis.fetch = async (input, init) => {
    const url = input instanceof Request ? input.url : input.toString();
    const method =
      init?.method ?? (input instanceof Request ? input.method : 'GET');

    logger.debug(`➡️ ${method} ${url}`, {
      headers: init?.headers,
      body: init?.body,
    });

    const start = performance.now();

    try {
      const response = await originalFetch(input, init);

      // Log response body without consuming the actual response
      const clone = response.clone();
      await clone.text().then(body => {
        logger.debug(
          `⬅️ ${response.status} ${method} ${url} (${Math.round(performance.now() - start)}ms)`,
          {
            body: body,
          },
        );
      });
      return response;
    } catch (error) {
      logger.error(`💥 ${method} ${url}`, error);
      throw error;
    }
  };
}
