import { Adres } from '../brp/adres-entity';
import { Persoon } from '../brp/persoon-entity';
import { PostgresqlManager } from './postgresql-manager';
import { createLo3AdresInsertStatement,
         createLo3PlInsertStatement,
         createLo3PlPersoonInsertStatement,
        createLo3PlVerblijfplaatsInsertStatement } from './sql-statements-factory';

export async function createAdres(adres: Adres): Promise<void> {
    const statement = createLo3AdresInsertStatement(adres);
    const result = await PostgresqlManager.getInstance().execute(statement);

    for (const key of adres.getPropertyNames()) {
        if(!adres[key as keyof Adres] && result.has(key)) {
            (adres as any)[key] = result.get(key);
        }
    }
}

export async function createPersoon(persoon: Persoon): Promise<void> {
    let statement = createLo3PlInsertStatement(persoon);
    let result = await PostgresqlManager.getInstance().execute(statement);

    for (const key of persoon.getPropertyNames()) {
        if(!persoon[key as keyof Persoon] && result.has(key)) {
            (persoon as any)[key] = result.get(key);
        }
    }

    statement = createLo3PlPersoonInsertStatement(persoon);
    result = await PostgresqlManager.getInstance().execute(statement);

    for (const key of persoon.getPropertyNames()) {
        if(!persoon[key as keyof Persoon] && result.has(key)) {
            (persoon as any)[key] = result.get(key);
        }
    }

    if(persoon.verblijfplaats !== undefined) {

        let statement2 = createLo3PlVerblijfplaatsInsertStatement(persoon);
        await PostgresqlManager.getInstance().execute(statement2);
    }
}

