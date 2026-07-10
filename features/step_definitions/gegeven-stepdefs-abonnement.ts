import { Given } from '@cucumber/cucumber';
import { AfnemerFactory } from './support/afnemer-factory';
import {
  abonneerOpGebeurtenistypeVanPersoon,
  deregistreerAbonneeVoorAfnemer,
  registreerAbonneeVoorAfnemer,
  verwijderGebeurtenistypeUitGroep,
  verwijderGroepVanAbonnee,
  voegGebeurtenistypeToeAanGroep,
  voegGroepToeBijAbonnee,
  zegOpAbonnementOpGebeurtenistypeVanPersoon,
} from './support/abonnement-api-helpers';
import {
  createObjectArrayFrom,
  createObjectFrom,
} from './support/dataTable2Object';
import { expect } from 'chai';
import { HttpStatusCode } from 'axios';

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
      'http statuscode is niet correct'
    );
  }
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
      'http statuscode is niet correct'
    );
  }
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
      'http statuscode is niet correct'
    );
  }
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
      'http statuscode is niet correct'
    );
  }
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
      'http statuscode is niet correct'
    );
  }
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
      'http statuscode is niet correct'
    );
  }
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
      .split(','); // gebeurtenistypes is een lijst gescheiden door een komma of het woord "en", al dan niet omgeven door spaties

    gebeurtenistypeLijst.forEach(async gebeurtenistype => {
      this.result = await voegGebeurtenistypeToeAanGroep(
        afnemer,
        abonneeNaam,
        groepNaam,
        gebeurtenistype,
      );
      expect(this.result.statusCode).to.equal(
        HttpStatusCode.Created, 
        'http statuscode is niet correct'
      );
    });
  }
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
      'http statuscode is niet correct'
    );
  }
);

Given('is niet geregistreerd als abonnee van BRP API Gebeurtenissen', () => { });

Given('is geregistreerd als abonnee van BRP API Gebeurtenissen', () => { });

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
        expect(this.result.statusCode).to.equal(HttpStatusCode.Created, 'http statuscode is niet correct');
        break;
      case 'AbonneeGederegistreerd':
        this.result = await deregistreerAbonneeVoorAfnemer(
          afnemer,
          gebeurtenis.abonneeNaam,
        );
        expect(this.result.statusCode).to.equal(HttpStatusCode.NoContent, 'http statuscode is niet correct');
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
      }
    }
  },
);

Given(
  'de abonnee {string} van afnemer {string} heeft zich geabonneerd op de {string} gebeurtenissen van {string}',
  async function (
    abonneeNaam,
    afnemerAanduiding,
    gebeurtenistype,
    persoonAanduiding,
  ) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    if (!afnemer.abonnees.includes(abonneeNaam)) {
      await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    }

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      abonneeNaam,
      `nl.brp.${gebeurtenistype}`,
      persoon,
    );
  },
);

Given(
  'de abonnee {string} van afnemer {string} heeft zijn abonnement op de {string} gebeurtenissen van {string} opgezegd',
  async function (
    abonneeNaam,
    afnemerAanduiding,
    gebeurtenistype,
    persoonAanduiding,
  ) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    if (!afnemer.abonnees.includes(abonneeNaam)) {
      await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    }

    this.result = await zegOpAbonnementOpGebeurtenistypeVanPersoon(
      afnemer,
      abonneeNaam,
      `nl.brp.${gebeurtenistype}`,
      persoon,
    );
  },
);

Given(
  'de abonnee {string} van afnemer {string} heeft een abonnement op de {string} gebeurtenissen van {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    gebeurtenistype: string,
    persoonAanduiding: string,
  ) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    if (!afnemer.abonnees.includes(abonneeNaam)) {
      await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    }

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      abonneeNaam,
      `nl.brp.${gebeurtenistype}`,
      persoon,
    );
  },
);
