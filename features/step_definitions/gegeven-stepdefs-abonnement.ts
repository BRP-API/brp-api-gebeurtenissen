import {Given} from '@cucumber/cucumber';
import {AfnemerFactory} from './support/afnemer-factory.js';
import {PersoonFactory} from './support/persoon-factory.js';
import {
  abonneerPersoonOpGroep,
  deregistreerAbonneeVoorAfnemer,
  raadpleegAbonnementen,
  registreerAbonneeVoorAfnemer,
  verwijderGebeurtenistypeUitGroep,
  verwijderGroepVanAbonnee,
  voegGebeurtenistypeToeAanGroep,
  voegGroepToeBijAbonnee,
} from './support/abonnement-api-helpers.js';
import {
  createObjectArrayFrom,
  createObjectArrayWithPersoonAanduidingenFrom,
  createObjectFrom,
} from './support/dataTable2Object.js';
import {expect} from 'chai';
import {HttpStatusCode} from 'axios';
import {Afnemer} from './brp/afnemer-entity.js';
import {Persoon} from './brp/persoon-entity.js';
import {expectEventuallyWithRetry} from './support/custom-assertions/expectEventually.js';

Given(
  'de afnemer {string} heeft de abonnee {string} geregistreerd',
  async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de afnemer {string} heeft de abonnee {string} gederegistreerd',
  async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await deregistreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.NoContent,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de afnemer {string} heeft bij de abonnee {string} de groep {string} toegevoegd',
  async function (
    afnemerAanduiding: string,
    abonneeNaam: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await voegGroepToeBijAbonnee(afnemer, abonneeNaam, groepNaam);
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de afnemer {string} heeft bij de abonnee {string} de groep {string}',
  async function (
    afnemerAanduiding: string,
    abonneeNaam: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await voegGroepToeBijAbonnee(afnemer, abonneeNaam, groepNaam);
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de afnemer {string} heeft bij de abonnee {string} de groep {string} verwijderd',
  async function (
    afnemerAanduiding: string,
    abonneeNaam: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await verwijderGroepVanAbonnee(
      afnemer,
      abonneeNaam,
      groepNaam,
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.NoContent,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de afnemer {string} heeft bij de abonnee {string} het gebeurtenistype {string} aan de groep {string} toegevoegd',
  async function (
    afnemerAanduiding: string,
    abonneeNaam: string,
    gebeurtenistype: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await voegGebeurtenistypeToeAanGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      gebeurtenistype,
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'groep {string} bij abonnee {string} van afnemer {string} heeft gebeurtenistype(s) {string}',
  async function (
    groepNaam: string,
    abonneeNaam: string,
    afnemerAanduiding: string,
    gebeurtenistypes: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );
    const gebeurtenistypeLijst = gebeurtenistypes
      .replace(' en ', ',')
      .replace(' ', '')
      .split(','); // gebeurtenistypes is een lijst gescheiden door een komma of het woord 'en', al dan niet omgeven door spaties

    for (const gebeurtenistype of gebeurtenistypeLijst) {
      this.result = await voegGebeurtenistypeToeAanGroep(
        afnemer,
        abonneeNaam,
        groepNaam,
        gebeurtenistype,
      );
      expect(this.result.statusCode).to.equal(
        HttpStatusCode.Created,
        'http statuscode is niet correct',
      );
    }
  },
);

Given(
  'de afnemer {string} heeft bij de abonnee {string} het gebeurtenistype {string} uit de groep {string} verwijderd',
  async function (
    afnemerAanduiding: string,
    abonneeNaam: string,
    gebeurtenistype: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await verwijderGebeurtenistypeUitGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      gebeurtenistype,
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.NoContent,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de abonnee {string} van afnemer {string} heeft een abonnement op de persoon {string} voor de groep {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
    groepNaam: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'AbonneerPersoonOpGroep',
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );
  },
);

Given(
  'de abonnee {string} van afnemer {string} heeft het abonnement op de persoon {string} voor de groep {string} opgezegd',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
    groepNaam: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'ZegOpAbonnementVanPersoonOpGroep',
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.NoContent,
      'http statuscode is niet correct',
    );
  },
);

Given('is niet geregistreerd als abonnee van BRP API Gebeurtenissen', () => {});

Given('is geregistreerd als abonnee van BRP API Gebeurtenissen', () => {});

Given(
  'de abonnee {string} van afnemer {string} heeft een abonnement op {string} gebeurtenissen van {string}',
  async function (
    abonneeNaam,
    afnemerAanduiding,
    gebeurtenistype,
    persoonAanduiding,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );

    const groepNaam = 'standaard-groep';
    this.result = await voegGroepToeBijAbonnee(afnemer, abonneeNaam, groepNaam);
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );

    this.result = await voegGebeurtenistypeToeAanGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      gebeurtenistype,
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );

    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    this.result = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'AbonneerPersoonOpGroep',
    );
    expect(this.result.statusCode).to.equal(
      HttpStatusCode.Created,
      'http statuscode is niet correct',
    );
  },
);

async function voegGroepenToe(
  groepNummer: number,
  maximaalAantal: number,
  context: any,
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaamBasis = 'groep',
) {
  const groepNaam = groepNaamBasis + groepNummer.toString();

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

  if (groepNummer < maximaalAantal) {
    await voegGroepenToe(
      groepNummer + 1,
      maximaalAantal,
      context,
      afnemer,
      abonneeNaam,
      groepNaamBasis,
    );
  }
}

async function abonneerPersonen(
  abonnementNummer: number,
  maximaalAantal: number,
  context: any,
  afnemer: Afnemer,
  abonneeNaam: string,
  groepNaamBasis = 'groep',
) {
  const aantalPersonen = Object.keys(context.personen).length;

  const persoonAanduiding = Object.keys(context.personen)[
    (abonnementNummer - 1) % aantalPersonen
  ];
  const persoon = await PersoonFactory.create(context, persoonAanduiding);

  const groepNaam =
    groepNaamBasis +
    (Math.floor((abonnementNummer - 1) / aantalPersonen) + 1).toString();
  const abonneerResult = await abonneerPersoonOpGroep(
    afnemer,
    abonneeNaam,
    groepNaam,
    persoon,
    'AbonneerPersoonOpGroep',
  );
  expect(abonneerResult.statusCode).to.equal(
    HttpStatusCode.Created,
    `http statuscode is niet correct bij abonneren van ${persoonAanduiding} op groep ${groepNaam}`,
  );

  if (abonnementNummer < maximaalAantal) {
    await abonneerPersonen(
      abonnementNummer + 1,
      maximaalAantal,
      context,
      afnemer,
      abonneeNaam,
      groepNaamBasis,
    );
  }
}

Given(
  'er zijn {int} abonnementen voor abonnee {string} van afnemer {string}',
  {timeout: 60000},
  async function (
    aantalAbonnementen: number,
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

    const aantalPersonen = Object.keys(this.context.personen).length;
    const aantalGroepen = Math.ceil(aantalAbonnementen / aantalPersonen);

    await voegGroepenToe(1, aantalGroepen, this.context, afnemer, abonneeNaam);

    await abonneerPersonen(
      1,
      aantalAbonnementen,
      this.context,
      afnemer,
      abonneeNaam,
    );
  },
);

Given(
  'er is een {string} gebeurtenis gepubliceerd met de volgende velden',
  async function (gebeurtenisType, dataTable) {
    const gebeurtenis = createObjectFrom(dataTable);

    const afnemer = await AfnemerFactory.create(
      this.context,
      gebeurtenis.afnemerId,
    );

    switch (gebeurtenisType) {
      case 'AbonneeGeregistreerd':
        this.result = await registreerAbonneeVoorAfnemer(
          afnemer,
          gebeurtenis.abonneeNaam,
        );
        expect(this.result.statusCode).to.equal(
          HttpStatusCode.Created,
          'http statuscode is niet correct',
        );
        break;
      case 'AbonneeGederegistreerd':
        this.result = await deregistreerAbonneeVoorAfnemer(
          afnemer,
          gebeurtenis.abonneeNaam,
        );
        expect(this.result.statusCode).to.equal(
          HttpStatusCode.NoContent,
          'http statuscode is niet correct',
        );
        break;
      default:
        throw new Error(`Onbekend gebeurtenisType: ${gebeurtenisType}`);
    }
  },
);

Given(
  'de volgende {string} gebeurtenissen zijn gepubliceerd',
  async function (gebeurtenisType, dataTable) {
    if (gebeurtenisType === 'AbonneeGeregistreerd') {
      const gebeurtenissen = createObjectArrayFrom(dataTable);

      for (const gebeurtenis of gebeurtenissen) {
        const afnemer = await AfnemerFactory.create(
          this.context,
          gebeurtenis.afnemerId,
        );

        this.result = await registreerAbonneeVoorAfnemer(
          afnemer,
          gebeurtenis.abonneeNaam,
        );
        expect(this.result.statusCode).to.equal(
          HttpStatusCode.NoContent,
          'http statuscode is niet correct',
        );
      }
    }
  },
);

Given(
  'er een abonnement is op persoon {string} voor de groep {string} van de abonnee {string} van afnemer {string}',
  async function (
    perssonAanduiding: string,
    groepNaam: string,
    abonneeNaam: string,
    afnemerAanduiding: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.resultProducer = async () => {
      this.resultProducer = async () =>
        await raadpleegAbonnementen(afnemer, abonneeNaam);
    };
    this.result = await this.resultProducer().body;

    this.expected = {
      groep: groepNaam,
      burgerservicenummer: '000000001',
    };

    await expectEventuallyWithRetry(
      this.result,
      async () => (await this.resultProducer()).body,
      result => {
        this.result = result;
        console.log(JSON.stringify(this.result.abonnementen, null, 2));
        console.log(JSON.stringify(this.expected, null, 2));
        expect(this.result.abonnementen)
          .excludingEvery('id')
          .to.deep.include(this.expected);
      },
    );

    this.expected = null;
  },
);
