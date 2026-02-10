import { DataTable, Then } from '@cucumber/cucumber';
import { expect } from 'chai';
import { createLo3AdresInsertStatement, createInsertStatements, SqlStatement } from './support/sql-statements-factory';
import { createObjectFrom } from './support/dataTable2Object';
import { generateClientScopeJSON, generateClientJSON, generateProtocollMapperJSON, fetchClientVoorAfnemer } from './support/oauth-helpers';

Then('heeft het adres {string} geen eigenschappen', function (adresAanduiding: string) {
  expect(this.context.adressen[adresAanduiding]).to.deep.equal({});
});

Then('heeft het adres {string} de volgende eigenschappen', function (adresAanduiding: string, dataTable: DataTable) {
  expect(this.context.adressen[adresAanduiding]).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft de afnemer {string} de volgende eigenschappen', function (afnemerAanduiding: string, dataTable: DataTable) {
  const afnemer = this.context.afnemers[afnemerAanduiding];

  delete afnemer.clientSetup; // verwijder clientSetup property tbv object validatie

  expect(afnemer).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft de persoon {string} de volgende eigenschappen', function (persoonAanduiding: string, dataTable: DataTable) {
  expect(this.context.personen[persoonAanduiding]).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft persoon {string} een verblijfplaats met de volgende eigenschappen', function (persoonAanduiding: string, dataTable: DataTable) {
  expect(this.context.personen[persoonAanduiding].verblijfplaats.getClone()).to.deep.equal(dataTable.hashes()[0]);
});

Then('heeft de command de volgende eigenschappen', function (dataTable: DataTable) {
  expect(this.command).to.deep.equal(createObjectFrom(dataTable));
});

Then('zijn de gegenereerde sql statements voor adres {string}', function (adresAanduiding: string, dataTable: DataTable) {
  const expected = dataTable
    .hashes()
    .map((row) => new SqlStatement(row.statementText, row.values ? row.values.split(',').map((value) => value.trim()) : []));

  const actual = createLo3AdresInsertStatement(this.context.adressen[adresAanduiding]);

  let index = 0;
  for (const expectedStatement of expected) {
    const actualStatement = actual;

    expect(actualStatement.statementText, `Statement text at index ${index}`).to.equal(expectedStatement.statementText);

    expect(actualStatement.values, `Statement values at index ${index}`).to.deep.equal(expectedStatement.values);

    index++;
  }
});

Then('zijn de gegenereerde sql statements voor persoon {string}', function (persoonAanduiding: string, dataTable: DataTable) {
  const expected = dataTable
    .hashes()
    .map((row) => new SqlStatement(row.statementText, row.values ? row.values.split(',').map((value) => value.trim()) : []));

  const actual = createInsertStatements(this.context.personen[persoonAanduiding]);

  let index = 0;
  for (const expectedStatement of expected) {
    const actualStatement = actual[index];

    expect(actualStatement.statementText, `Statement text at index ${index}`).to.equal(expectedStatement.statementText);

    expect(actualStatement.values, `Statement values at index ${index}`).to.deep.equal(expectedStatement.values);

    index++;
  }
});

Then('is de gegenereerde client scope JSON voor afnemer {string}', function (afnemerAanduiding: string, docString: string) {
  const afnemer = this.context.afnemers[afnemerAanduiding];
  const expectedClientScopeJson = JSON.parse(docString);

  expect(generateClientScopeJSON(afnemer.oin)).to.deep.equal(expectedClientScopeJson);
});

Then('is de gegenereerde client JSON voor afnemer {string}', function (afnemerAanduiding: string, docString: string) {
  const afnemer = this.context.afnemers[afnemerAanduiding];
  const expectedClientJson = JSON.parse(docString);

  expect(generateClientJSON(afnemer.aanduiding, 'secret')).to.deep.equal(expectedClientJson);
});

Then('is de gegenereerde protocol mapper JSON voor afnemer {string}', function (afnemerAanduiding: string, docString: string) {
  const afnemer = this.context.afnemers[afnemerAanduiding];
  const expectedClientJson = JSON.parse(docString);

  expect(generateProtocollMapperJSON(afnemer.oin || '000000099000000010000', afnemer.afnemerId || '000001', afnemer.gemeenteCode)).to.deep.equal(
    expectedClientJson
  );
});

Then('is de client succesvol aangemaakt in Keycloak voor afnemer {string}', async function (afnemerAanduiding: string) {
  if (!this.isStapDocumentatieIntegratieScenario) {
    return;
  }

  const afnemer = this.context.afnemers[afnemerAanduiding];

  const client = await fetchClientVoorAfnemer(afnemer);

  expect(client.id).to.equal(afnemer.idpId);
  expect(client.clientId).to.equal(afnemer.aanduiding);
  const gemeenteCodeClaim = afnemer.gemeenteCode ? `,"gemeenteCode=${afnemer.gemeenteCode}"` : '';
  expect(client.protocolMappers[0].config['claim.value']).to.equal(`["OIN=${afnemer.oin}","afnemerID=${afnemer.afnemerId}"${gemeenteCodeClaim}]`);
});
