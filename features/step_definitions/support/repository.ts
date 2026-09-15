import {Adres} from '../brp/adres-entity.js';
import {Afnemer} from '../brp/afnemer-entity.js';
import {Persoon} from '../brp/persoon-entity.js';
//import {logger} from './logger.js';
import {PostgresqlManager} from './postgresql-manager.js';
import {
  createLo3AdresInsertStatement,
  createLo3AdresUpdateStatement,
  createLo3AutorisatieInsertStatement,
  createLo3PlInsertStatement,
  createLo3PlPersoonInsertStatement,
  createLo3PlVerblijfplaatsInsertStatement,
  createLo3PlVerblijfplaatsOpAdresInsertStatement,
  createLo3PlVerblijfplaatsVolgnummerUpdateStatement,
  createLo3AdresDeleteStatement,
  createLo3PersoonDeleteStatements,
} from './sql-statements-factory.js';

export async function createAdres(adres: Adres): Promise<Adres> {
  const statement = createLo3AdresInsertStatement(adres);
  const result = await PostgresqlManager.getInstance().execute(statement);

  for (const key of adres.getPropertyNames()) {
    if (!adres[key as keyof Adres] && result.has(key)) {
      (adres as any)[key] = result.get(key);
    }
  }

  return adres;
}

export async function updateAdres(
  adres: Adres,
  property: string,
  value: string,
): Promise<void> {
  const statement = createLo3AdresUpdateStatement(adres, property, value);
  await PostgresqlManager.getInstance().execute(statement);
}

export async function createAutorisatie(afnemer: Afnemer): Promise<void> {
  const statement = createLo3AutorisatieInsertStatement(afnemer);
  const result = await PostgresqlManager.getInstance().execute(statement);

  if (!afnemer.afnemerId) {
    afnemer.afnemerId = result.get('afnemer_code');
  }
}

export async function createPersoon(persoon: Persoon): Promise<void> {
  let statement = createLo3PlInsertStatement(persoon);
  let result = await PostgresqlManager.getInstance().execute(statement);

  for (const key of persoon.getPropertyNames()) {
    if (!persoon[key as keyof Persoon] && result.has(key)) {
      (persoon as any)[key] = result.get(key);
    }
  }

  statement = createLo3PlPersoonInsertStatement(persoon);
  result = await PostgresqlManager.getInstance().execute(statement);

  for (const key of persoon.getPropertyNames()) {
    if (!persoon[key as keyof Persoon] && result.has(key)) {
      (persoon as any)[key] =
        key === 'burger_service_nr'
          ? String(result.get(key)).padStart(9, '0')
          : result.get(key);
    }
  }

  if (persoon.verblijfplaats !== undefined) {
    await createVerblijfPlaatsVoorPersoon(persoon);
  }
}

export async function createVerblijfPlaatsVoorPersoon(
  persoon: Persoon,
): Promise<void> {
  const sqlStatement = createLo3PlVerblijfplaatsInsertStatement(persoon);
  await PostgresqlManager.getInstance().execute(sqlStatement);
}

export async function createVerblijfPlaatsVoorPersoonOpAdres(
  persoon: Persoon,
  adres: Adres,
  datumVan: string,
): Promise<void> {
  const updateSqlStatement =
    createLo3PlVerblijfplaatsVolgnummerUpdateStatement(persoon);
  await PostgresqlManager.getInstance().execute(updateSqlStatement);

  const sqlStatement = createLo3PlVerblijfplaatsOpAdresInsertStatement(
    persoon,
    adres,
    datumVan,
  );
  await PostgresqlManager.getInstance().execute(sqlStatement);
}

export async function deleteAdres(adres: Adres): Promise<void> {
  const statement = createLo3AdresDeleteStatement(adres);
  await PostgresqlManager.getInstance().execute(statement);
}

export async function deletePersoon(persoon: Persoon): Promise<void> {
  const statements = createLo3PersoonDeleteStatements(persoon);

  for (const statement of statements) {
    await PostgresqlManager.getInstance().execute(statement);
  }
}
