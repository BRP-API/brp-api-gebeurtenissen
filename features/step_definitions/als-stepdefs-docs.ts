import { DataTable, When, Then } from '@cucumber/cucumber';
import { createLo3AdresInsertStatement,
         createLo3PlInsertStatement,
         createLo3PlPersoonInsertStatement,
        createSelectStatement } from './support/sql-statements-factory';
import { PostgresqlManager } from './support/postgresql-manager';
import { stringifyValues } from './support/object-utils';
import { expect } from 'chai';

When('de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd', async function () {
    if(this.context.adressen) {
        for(const adresAanduiding of Object.keys(this.context.adressen)) {
            const adres = this.context.adressen[adresAanduiding];
            const statement = createLo3AdresInsertStatement(adres);
            const result = await PostgresqlManager.getInstance().execute(statement);

            adres.getPropertyNames().forEach((key: string) => {
                if(!adres[key] && result.has(key)) {
                    adres[key] = result.get(key);
                }
            });
        }
    }

    if(this.context.personen) {
        for(const persoonAanduiding of Object.keys(this.context.personen)) {
            const persoon = this.context.personen[persoonAanduiding];
            let statement = createLo3PlInsertStatement(persoon);
            let result = await PostgresqlManager.getInstance().execute(statement);

            persoon.getPropertyNames().forEach((key: string) => {
                if(!persoon[key] && result.has(key)) {
                    persoon[key] = result.get(key);
                }
            });
            this.logger.info('aangepast persoon:', persoon);

            statement = createLo3PlPersoonInsertStatement(persoon);
            result = await PostgresqlManager.getInstance().execute(statement);

            persoon.getPropertyNames().forEach((key: string) => {
                if(!persoon[key] && result.has(key)) {
                    persoon[key] = result.get(key);
                }
            });
            this.logger.info('aangepast persoon na pl_persoon:', persoon);
        }
    }
});

Then('heeft tabel {string} de volgende rij', async function (tabel: string, dataTable: DataTable) {
    for(const expected of dataTable.hashes()) {
        if(tabel === 'lo3_adres') {
            for(const [column, value] of Object.entries(expected)) {
                if(Object.keys(this.context.adressen).includes(value)) {
                    expected[column] = this.context.adressen[value][column];
                }
            }
        }
        if(tabel === 'lo3_pl' || tabel === 'lo3_pl_persoon') {
            for(const [column, value] of Object.entries(expected)) {
                if(Object.keys(this.context.personen).includes(value)) {
                    expected[column] = this.context.personen[value][column];
                }
            }
        }

        const statement = createSelectStatement(tabel, Object.keys(expected), Object.values(expected));

        const result = await PostgresqlManager.getInstance().execute(statement);

        const actual = Object.fromEntries(result);

        expect(stringifyValues(actual)).to.deep.equal(stringifyValues(expected));
    }
});
