import { createLogger, format, transports, Logger } from 'winston';

export function createWinstonLogger(logLevel: string): Logger {
    return createLogger({
        level: logLevel,
        transports: [
            new transports.Console({
                format: format.prettyPrint()
            })
        ]
    });
};
