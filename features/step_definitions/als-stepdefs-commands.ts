import {DataTable, When} from '@cucumber/cucumber';
import {Aanduiding} from './support/aanduiding';
import {
  AangifteVanAdreswijzigingCommand,
  AangifteVanVertrekNaarBuitenlandCommand,
} from './brp-api/commands';
import {createObjectFrom} from './support/dataTable2Object';
import {sendCommand} from './support/mutatie-api-helpers';
import {expect} from 'chai';
import {HttpStatusCode} from 'axios';

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
