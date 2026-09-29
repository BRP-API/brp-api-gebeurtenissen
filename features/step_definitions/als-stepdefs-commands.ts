import {DataTable, When, defineParameterType} from '@cucumber/cucumber';
import {Aanduiding} from './support/aanduiding.js';
import {
  AangifteVanAdreswijzigingCommand,
  AangifteVanVertrekNaarBuitenlandCommand,
} from './brp-api/commands.js';
import {createObjectFrom} from './support/dataTable2Object.js';
import {sendCommand} from './support/mutatie-api-helpers.js';
import {expect} from 'chai';
import {HttpStatusCode} from 'axios';
import {toIsoDate} from './support/date-utils.js';

When(
  'de aangifte van adreswijziging van {string} is verwerkt',
  function (persoonAanduiding: string) {
    this.command = new AangifteVanAdreswijzigingCommand(
      this.context.personen[persoonAanduiding].burger_service_nr,
    );

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
  },
);

When(
  'de aangifte van vertrek naar het buitenland van {string} is verwerkt',
  function (persoonAanduiding: string) {
    this.command.type = 'AangifteVanVertrek';
    this.command.burgerservicenummer =
      this.context.personen[persoonAanduiding].burger_service_nr;

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
  },
);

When(
  'de aangifte van vertrek naar buitenland van {string} is verwerkt met de volgende gegevens',
  async function (persoonAanduiding: string, dataTable: DataTable) {
    const dataTableObject = createObjectFrom(dataTable);
    this.command = new AangifteVanVertrekNaarBuitenlandCommand(
      this.context.personen[persoonAanduiding].burger_service_nr,
      dataTableObject.landCode,
      dataTableObject.datumEmigratie,
      dataTableObject.regel1,
      dataTableObject.regel2,
      dataTableObject.regel3,
    );
    const response = await sendCommand(this.command);
    expect(response.status).to.equal(HttpStatusCode.Created);
  },
);

defineParameterType({
  name: 'functie-adres',
  regexp: /woonadres|briefadres/,
  transformer: s => s.substring(0, 1).toUpperCase(),
});

When(
  'de aangifte van adreswijziging van {string} vanaf {string} naar het (woon)(brief)adres {string} is verwerkt',
  async function (persoonAanduiding, datumAanvang, adresAanduiding) {
    this.command = new AangifteVanAdreswijzigingCommand(
      this.context.personen[persoonAanduiding].burger_service_nr,
      this.context.adressen[adresAanduiding].verblijf_plaats_ident_code,
      toIsoDate(datumAanvang),
    );
    const response = await sendCommand(this.command);
    expect(response.status).to.equal(HttpStatusCode.Created);
  },
);
