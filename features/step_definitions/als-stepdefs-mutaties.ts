import {When} from '@cucumber/cucumber';
import {RegistreerAdresCommand} from './brp-api/adres-commands.js';
import {sendMuteerAdresCommand} from './support/mutatie-api-helpers.js';

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

When(
  'het adres {string} in gemeente {string} wordt geregistreerd in de BRP',
  async function (adresAanduiding: string, gemeentenaam: string) {
    const gemeenteCodeMap: {[key: string]: string} = {
      Amsterdam: '0363',
      'Den Haag': '0518',
      Hengelo: '0164',
      Roosendaal: '1674',
      Rotterdam: '0599',
      Utrecht: '0344',
    };
    const command = new RegistreerAdresCommand();
    command.gemeentecode = gemeenteCodeMap[gemeentenaam] || gemeentenaam;

    const response = await sendMuteerAdresCommand(command);
    if (response.statusCode === 201) {
      if (!this.context.adressen) {
        this.context.adressen = {};
      }

      this.context.actueelAdres = adresAanduiding;

      let adres = this.context.adressen[adresAanduiding];

      if (!adres) {
        adres = {};

        this.context.adressen[adresAanduiding] = adres;
      }

      adres['adres_id'] = response.body.adresId;
      adres['gemeente_code'] = command.gemeentecode;
      adres['verblijf_plaats_ident_code'] =
        response.body.adresseerbaarObjectIdentificatie;
    }

    this.result = response.body;
  },
);
