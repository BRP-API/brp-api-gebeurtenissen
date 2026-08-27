import {When} from '@cucumber/cucumber';
import {raadpleegGebeurtenissenVoorAbonnee} from './support/gebeurtenissen-api-helpers.js';
import {AfnemerFactory} from './support/afnemer-factory.js';

When(
  'gebeurtenissen worden gevraagd door abonnee {string} van afnemer {string}',
  async function (abonneeNaam: string, afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.resultProducer = async () =>
      await raadpleegGebeurtenissenVoorAbonnee(afnemer, abonneeNaam);
    const response = await this.resultProducer();
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'abonnee {string} van afnemer {string} de gebeurtenissen vraagt na de gebeurtenis voor {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );
    const persoon = this.context.personen[persoonAanduiding];

    this.resultProducer = this.resultProducer = async () =>
      await raadpleegGebeurtenissenVoorAbonnee(
        afnemer,
        abonneeNaam,
        undefined,
        persoon,
      );
    const response = await this.resultProducer();
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'abonnee {string} van afnemer {string} maximaal {int} gebeurtenis(sen) vraagt',
  async function (abonneeNaam: string, afnemerAanduiding, limit: bigint) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.resultProducer = async () =>
      await raadpleegGebeurtenissenVoorAbonnee(afnemer, abonneeNaam, limit);
    const response = await this.resultProducer();
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'abonnee {string} van afnemer {string} maximaal {int} gebeurtenis vraagt na de gebeurtenis voor {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding,
    limit: bigint,
    persoonAanduiding: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );
    const persoon = this.context.personen[persoonAanduiding];

    this.resultProducer = async () =>
      await raadpleegGebeurtenissenVoorAbonnee(
        afnemer,
        abonneeNaam,
        limit,
        persoon,
      );
    const response = await this.resultProducer();
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'gebeurtenissen worden gevraagd met een abonneenaam die niet geregistreerd is',
  async function () {
    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Amsterdam',
    );
    const abonneeNaam = 'bestaat-niet';

    const response = await raadpleegGebeurtenissenVoorAbonnee(
      afnemer,
      abonneeNaam,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'gebeurtenissen worden gevraagd door abonnee {string} vanaf gebeurtenis {string}',
  async function (abonneeNaam: string, cursor) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Amsterdam',
    );

    const response = await raadpleegGebeurtenissenVoorAbonnee(
      afnemer,
      abonneeNaam,
      undefined,
      undefined,
      cursor,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'gebeurtenissen worden gevraagd door abonnee {string} vanaf de gebeurtenis voor {string}',
  async function (abonneeNaam: string, persoonAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Amsterdam',
    );

    const gebeurtenisId =
      this.context.gebeurtenissen[persoonAanduiding].gebeurtenisId;

    const response = await raadpleegGebeurtenissenVoorAbonnee(
      afnemer,
      abonneeNaam,
      undefined,
      undefined,
      gebeurtenisId,
    );

    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);
