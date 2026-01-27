import { createLogger, format, transports, Logger } from 'winston';

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
}

export const logger = loggerInstance;
