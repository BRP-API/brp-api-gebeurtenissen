import { PoolConfig } from "pg";

export const poolConfig: PoolConfig = {
    user: 'root',
    host: 'localhost',
    database: 'rvig_haalcentraal_testdata',
    password: 'root',
    port: 5432,
    allowExitOnIdle: true
};
