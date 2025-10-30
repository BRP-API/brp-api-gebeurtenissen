import { Pool, PoolClient, PoolConfig, QueryResult } from 'pg';
import { Logger } from 'winston';
import { SqlStatement } from './sql-statements-factory';

export class PostgresqlManager {
    private static instance: PostgresqlManager | null = null;
    private pool: Pool;
    private logger: Logger;

    constructor(config: PoolConfig, logger: Logger) {
        this.pool = new Pool(config);
        this.logger = logger;

        this.logger.info('PostgreSQL connection pool created.');
    }

    public static setup(config: PoolConfig, logger: Logger): void {
        if (!PostgresqlManager.instance) {
            PostgresqlManager.instance = new PostgresqlManager(config, logger);
        }
    }

    public static getInstance(): PostgresqlManager {
        if (!PostgresqlManager.instance) {
            throw new Error('PostgresqlManager is not initialized. Call setup() first.');
        }
        return PostgresqlManager.instance;
    }

    async close(): Promise<void> {
        if (this.pool) {
            await this.pool.end();
            this.logger.info('PostgreSQL connection pool closed.');
        }
        PostgresqlManager.instance = null;
    }

    async execute(sqlStatement: SqlStatement): Promise<Map<string, any>> {
        const client: PoolClient = await this.pool.connect();

        try {
            this.logger.info(`Executing SQL: ${sqlStatement.statementText}`, sqlStatement.values);
            const result: QueryResult = await client.query(sqlStatement.statementText, sqlStatement.values);
            
            // Convert each row to a Map with only columns that have values
            const resultMap: Map<string, any> = new Map<string, any>();
            if (result.rows.length > 0) {
                Object.entries(result.rows[0]).forEach(([column, value]) => {
                    // Only add columns that have a value (not null, undefined, or empty string)
                    if (value !== null && value !== undefined && value !== '') {
                        resultMap.set(column, value);
                    }
                });
            }

            this.logger.info(`SQL executed successfully. Result: ${JSON.stringify(Object.fromEntries(resultMap))}`);

            return resultMap;
        } catch (error) {
            this.logger.error(`Error executing SQL: ${error}`);

            throw error;
        } finally {
            client.release();
        }
    }
}