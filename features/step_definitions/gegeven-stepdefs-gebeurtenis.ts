import {Given} from '@cucumber/cucumber';
import {PersoonFactory} from './support/persoon-factory.js';
import {
  publiceerGebeurtenis,
  raadpleegGebeurtenissenVoorAbonnee,
} from './support/gebeurtenissen-api-helpers.js';
import {
  registreerAbonneeVoorAfnemer,
  voegGebeurtenistypeToeAanGroep,
  voegGroepToeBijAbonnee,
} from './support/abonnement-api-helpers.js';
import {AfnemerFactory} from './support/afnemer-factory.js';
import {expect} from 'chai';
import {HttpStatusCode} from 'axios';
import {ProcessedGebeurtenisManager} from './support/proccessed-gebeurteniss-manager.js';

Given(
  'er is een {string} gebeurtenis gepubliceerd voor persoon {string}',
  async function (gebeurtenistype: string, persoonAanduiding: string) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    this.result = await publiceerGebeurtenis(gebeurtenistype, persoon);
    expect(this.result.statusCode).to.equal(HttpStatusCode.Created);
    if (!this.context.gebeurtenissen) {
      this.context.gebeurtenissen = {};
    }
    this.context.gebeurtenissen[persoonAanduiding] = this.result.body;

    await ProcessedGebeurtenisManager.getInstance().awaitGebeurtenissenProcessed(
      this.result.body.gebeurtenisId,
    );
  },
);

Given(
  'er is een {string} gebeurtenis gepubliceerd voor persoon {string} met datum {string}',
  async function (
    gebeurtenistype: string,
    persoonAanduiding: string,
    datumString: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    this.result = await publiceerGebeurtenis(
      gebeurtenistype,
      persoon,
      datumString,
    );
    expect(this.result.statusCode).to.equal(HttpStatusCode.Created);
    if (!this.context.gebeurtenissen) {
      this.context.gebeurtenissen = {};
    }
    this.context.gebeurtenissen[persoonAanduiding] = this.result.body;
  },
);

Given(
  'gebeurtenissen zijn gevraagd door abonnee {string} van afnemer {string}',
  async function (abonneeNaam: string, afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegGebeurtenissenVoorAbonnee(
      afnemer,
      abonneeNaam,
    );
  },
);

function dateFromDayOfYear(dayOfYear: number): string {
  const now = new Date();
  const date = new Date(now.getFullYear(), 0, dayOfYear);

  return (
    date.getFullYear() +
    (date.getMonth() + 1).toString().padStart(2, '0') +
    date.getDate().toString().padStart(2, '0')
  );
}

async function publiceerGebeurtenissen(
  gebeurtenisNummer: number,
  maximaalAantal: number,
  context: any,
  gebeurtenistype: string,
) {
  const aantalPersonen = Object.keys(context.personen).length;

  const persoonAanduiding = Object.keys(context.personen)[
    (gebeurtenisNummer - 1) % aantalPersonen
  ];
  const persoon = await PersoonFactory.create(context, persoonAanduiding);

  const PublishResult = await publiceerGebeurtenis(
    gebeurtenistype,
    persoon,
    dateFromDayOfYear(gebeurtenisNummer),
  );
  expect(PublishResult.statusCode).to.equal(HttpStatusCode.Created);
  if (!context.gebeurtenissen) {
    context.gebeurtenissen = {};
  }
  context.gebeurtenissen[persoonAanduiding] = PublishResult.body;

  if (gebeurtenisNummer < maximaalAantal) {
    await publiceerGebeurtenissen(
      gebeurtenisNummer + 1,
      maximaalAantal,
      context,
      gebeurtenistype,
    );
  }
}

Given(
  'er zijn {int} gebeurtenissen gepubliceerd waar abonnee {string} van afnemer {string} op geabonneerd is',
  {timeout: 60000},
  async function (
    aantal: number,
    abonneeNaam: string,
    afnemerAanduiding: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    if (
      !this.context.afnemers[afnemerAanduiding].abonnees.includes(abonneeNaam)
    ) {
      this.result = await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
      expect(this.result.statusCode).to.equal(
        HttpStatusCode.Created,
        'http statuscode is niet correct',
      );
    }

    const groepNaam = 'veel-gebruikte-groep';
    const groepResult = await voegGroepToeBijAbonnee(
      afnemer,
      abonneeNaam,
      groepNaam,
    );
    expect(groepResult.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );

    const gebeurtenistype = 'nl.brp.verhuisd.intergemeentelijk';
    const typeResult = await voegGebeurtenistypeToeAanGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      gebeurtenistype,
    );
    expect(typeResult.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );

    const aantalGepubliceerdeGebeurtenissen = Object.keys(
      this.context.gebeurtenissen,
    ).length;
    await publiceerGebeurtenissen(
      1 + aantalGepubliceerdeGebeurtenissen,
      aantal,
      this.context,
      gebeurtenistype,
    );
  },
);
