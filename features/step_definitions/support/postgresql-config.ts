import { PoolConfig } from "pg";
import * as dotenv from "dotenv";

dotenv.config();

export const poolConfig: PoolConfig = {
    user: process.env.PG_USER || '',
    host: 'localhost',
    database: 'rvig_haalcentraal_testdata',
    password: process.env.PG_PASSWORD || '',
    port: 5432,
    allowExitOnIdle: true
};
