import {Given} from '@cucumber/cucumber';
import {PersoonFactory} from './support/persoon-factory.js';
import {
  publiceerGebeurtenis,
  raadpleegGebeurtenissenVoorAbonnee,
} from './support/gebeurtenissen-api-helpers.js';
import {
  abonneerPersoonOpGroep,
  registreerAbonneeVoorAfnemer,
  voegGebeurtenistypeToeAanGroep,
  voegGroepToeBijAbonnee,
} from './support/abonnement-api-helpers.js';
import {AfnemerFactory} from './support/afnemer-factory.js';
import {expect} from 'chai';
import {HttpStatusCode} from 'axios';

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

function dateFromDay(day: number): string {
  const nu = new Date();
  const d0 = new Date(nu.getFullYear(), 0); // initialize a date in `year-01-01`
  const d1 = new Date(d0.setDate(day)); // add the number of days
  return (
    d1.getFullYear() +
    (d1.getMonth() + 1).toString().padStart(2, '0') +
    d1.getDate().toString().padStart(2, '0')
  );
}

async function publiceerGebeurtenissen(
  nummer: number,
  maximaalAantal: number,
  context: any,
  gebeurtenistype: string,
) {
  const aantalPersonen = Object.keys(context.personen).length;

  const persoonAanduiding = Object.keys(context.personen)[
    (nummer - 1) % aantalPersonen
  ];
  const persoon = await PersoonFactory.create(context, persoonAanduiding);

  const PublishResult = await publiceerGebeurtenis(
    gebeurtenistype,
    persoon,
    dateFromDay(nummer),
  );
  expect(PublishResult.statusCode).to.equal(HttpStatusCode.Created);
  if (!context.gebeurtenissen) {
    context.gebeurtenissen = {};
  }
  context.gebeurtenissen[persoonAanduiding] = PublishResult.body;

  if (nummer < maximaalAantal) {
    // const starttijd = Date.now();
    // const interval = 100;
    // while (Date.now() - starttijd < interval) {}

    await publiceerGebeurtenissen(
      nummer + 1,
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
