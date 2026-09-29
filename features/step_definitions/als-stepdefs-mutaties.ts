import {Given, When} from '@cucumber/cucumber';
import {RegistreerAdresCommand} from './brp-api/adres-commands.js';
import {RegistreerPersoonCommand} from './brp-api/persoon-commands.js';
import {
  sendMuteerAdresCommand,
  sendMuteerPersoonCommand,
} from './support/mutatie-api-helpers.js';
import {gemeenteCodeMap} from './support/gemeente-codes.js';
import {Adres} from './brp/adres-entity.js';
import {Persoon} from './brp/persoon-entity.js';

When(
  'een adres in een gemeente wordt geregistreerd in de BRP zonder het opgeven van de code van de gemeente',
  async function () {
    const command = new RegistreerAdresCommand();

    const response = await sendMuteerAdresCommand(command);

    this.result = response.body;
  },
);

When(
  'een adres in een gemeente wordt geregistreerd in de BRP met een gemeentecode {string}',
  async function (gemeentecode: string) {
    const command = new RegistreerAdresCommand();
    command.gemeentecode = gemeentecode;

    const response = await sendMuteerAdresCommand(command);

    this.result = response.body;
  },
);

When(
  'een adres in een gemeente wordt geregistreerd in de BRP met een gemeentecode die niet bestaat',
  async function () {
    const command = new RegistreerAdresCommand();
    command.gemeentecode = '9999';

    const response = await sendMuteerAdresCommand(command);

    this.result = response.body;
  },
);

async function registreerAdres(
  context: any,
  adresAanduiding: string,
  gemeentenaam: string,
): Promise<any> {
  const command = new RegistreerAdresCommand();
  command.gemeentecode = gemeenteCodeMap[gemeentenaam] || gemeentenaam;

  const response = await sendMuteerAdresCommand(command);
  if (response.statusCode === 201) {
    if (!context.adressen) {
      context.adressen = {};
    }

    context.actueelAdres = adresAanduiding;

    let adres = context.adressen[adresAanduiding];

    if (!adres) {
      adres = new Adres(
        command.gemeentecode,
        response.body.adresseerbaarObjectIdentificatie,
      );

      context.adressen[adresAanduiding] = adres;
    }

    adres['adres_id'] = response.body.adresId;
  }

  return response;
}

When(
  'het adres {string} in gemeente {string} wordt geregistreerd in de BRP',
  async function (adresAanduiding: string, gemeentenaam: string) {
    const response = await registreerAdres(
      this.context,
      adresAanduiding,
      gemeentenaam,
    );

    this.result = response.body;
  },
);

Given(
  'het adres {string} in gemeente {string} is geregistreerd in de BRP',
  async function (adresAanduiding: string, gemeentenaam: string) {
    const response = await registreerAdres(
      this.context,
      adresAanduiding,
      gemeentenaam,
    );

    this.result = response.body;
    this.expected = null;
  },
);

async function registreerPersoon(
  context: any,
  persoonAanduiding: string,
): Promise<any> {
  const command = new RegistreerPersoonCommand(persoonAanduiding);

  const response = await sendMuteerPersoonCommand(command);
  if (response.statusCode === 201) {
    if (!context.personen) {
      context.personen = {};
    }

    context.actueelPersoon = persoonAanduiding;

    let persoon = context.personen[persoonAanduiding];

    if (!persoon) {
      persoon = new Persoon(
        response.body.anummer,
        response.body.burgerservicenummer,
        persoonAanduiding,
      );

      context.personen[persoonAanduiding] = persoon;
    }

    persoon['pl_id'] = response.body.persoonId;
  }

  return response;
}

When(
  'de persoon {string} wordt geregistreerd in de BRP',
  async function (persoonAanduiding: string) {
    const response = await registreerPersoon(this.context, persoonAanduiding);

    this.result = response.body;
  },
);
