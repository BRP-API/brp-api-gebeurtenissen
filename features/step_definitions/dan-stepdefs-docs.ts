import { DataTable, Then } from '@cucumber/cucumber';
import { expect } from 'chai';
import { createLo3AdresInsertStatement,
         createInsertStatements, 
         SqlStatement } from './support/sql-statements-factory';

Then('heeft het adres {string} geen eigenschappen', function (adresAanduiding: string) {
    expect(this.context.adressen[adresAanduiding]).to.deep.equal({});
});

Then('heeft het adres {string} de volgende eigenschappen', function (adresAanduiding: string, dataTable: DataTable) {
    expect(this.context.adressen[adresAanduiding]).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft de persoon {string} de volgende eigenschappen', function (persoonAanduiding: string, dataTable: DataTable) {
    expect(this.context.personen[persoonAanduiding]).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft persoon {string} een verblijfplaats met de volgende eigenschappen', function (persoonAanduiding: string, dataTable: DataTable) {
    expect(this.context.personen[persoonAanduiding].verblijfplaats.getClone()).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft de command de volgende eigenschappen', function (dataTable: DataTable) {
    expect(this.command).to.deep.equal(dataTable.hashes()[0]);
});

Then('zijn de gegenereerde sql statements voor adres {string}', function (adresAanduiding: string, dataTable: DataTable) {
    const expected = dataTable.hashes().map(row => 
        new SqlStatement(row.statementText,
                         row.values ? row.values.split(',').map(value => value.trim()) : [])
    );

    const actual = createLo3AdresInsertStatement(this.context.adressen[adresAanduiding]);

    let index = 0;
    for (const expectedStatement of expected) {
        const actualStatement = actual;

        expect(actualStatement.statementText, `Statement text at index ${index}`)
            .to.equal(expectedStatement.statementText);

        expect(actualStatement.values, `Statement values at index ${index}`)
            .to.deep.equal(expectedStatement.values);

        index++;
    }
});

Then('zijn de gegenereerde sql statements voor persoon {string}', function (persoonAanduiding: string, dataTable: DataTable) {
    const expected = dataTable.hashes().map(row => 
        new SqlStatement(row.statementText,
                         row.values ? row.values.split(',').map(value => value.trim()) : [])
    );

    const actual = createInsertStatements(this.context.personen[persoonAanduiding]);

    let index = 0;
    for (const expectedStatement of expected) {
        const actualStatement = actual[index];
        
        expect(actualStatement.statementText, `Statement text at index ${index}`)
            .to.equal(expectedStatement.statementText);
            
        expect(actualStatement.values, `Statement values at index ${index}`)
            .to.deep.equal(expectedStatement.values);
        
        index++;
    }
});
