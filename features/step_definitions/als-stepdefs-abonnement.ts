import {When} from '@cucumber/cucumber';
import {
  abonneerOpGebeurtenistypeVanPersoon,
  deregistreerAbonneeVoorAfnemer,
  raadpleegAbonneesVoorAfnemer,
  raadpleegGebeurtenistypesInGroep,
  raadpleegGroepenVanAbonnee,
  registreerAbonneeVoorAfnemer,
  verwijderGebeurtenistypeUitGroep,
  verwijderGroepVanAbonnee,
  voegGebeurtenistypeToeAanGroep,
  voegGroepToeBijAbonnee,
  zegOpAbonnementenOpPersoon,
  zegOpAbonnementOpGebeurtenistypeVanPersoon,
} from './support/abonnement-api-helpers';
import {AfnemerFactory} from './support/afnemer-factory';
import {PersoonFactory} from './support/persoon-factory';
import {Persoon} from './brp/persoon-entity';

When(
  'de afnemer {string} de abonnee {string} registreert',
  async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de afnemer {string} een abonnee registreert zonder abonneeNaam',
  async function (afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await registreerAbonneeVoorAfnemer(afnemer);
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de afnemer {string} zijn abonnees raadpleegt',
  async function (afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegAbonneesVoorAfnemer(afnemer);
  },
);

When(
  'de afnemer {string} de abonnee {string} deregistreert',
  async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await deregistreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de afnemer {string} bij de abonnee {string} de groep {string} toevoegt',
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
  },
);

When(
  'de afnemer {string} bij de abonnee {string} de groep {string} verwijdert',
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
  },
);

When(
  'de afnemer {string} de groepen van abonnee {string} opvraagt',
  async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegGroepenVanAbonnee(afnemer, abonneeNaam);
  },
);

When(
  'de afnemer {string} bij de abonnee {string} het gebeurtenistype {string} aan de groep {string} toevoegt',
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
  },
);

When(
  'de afnemer {string} bij de abonnee {string} het gebeurtenistype {string} uit de groep {string} verwijdert',
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
  },
);

When(
  'de afnemer {string} de gebeurtenistypes van groep {string} van abonnee {string} opvraagt',
  async function (
    afnemerAanduiding: string,
    groepNaam: string,
    abonneeNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegGebeurtenistypesInGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
    );
  },
);

When(
  'een afnemer zonder abonnees een abonnement op een gebeurtenis van een persoon wil nemen',
  async function () {
    const persoon = await PersoonFactory.create(this.context, 'Jan');

    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Den Haag',
    );

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      'jz',
      'nl.brp.verhuisd.intergemeentelijk',
      persoon,
    );
  },
);

When(
  'een afnemer met een niet-geregistreerde abonnee een abonnement op een gebeurtenis van een persoon wil nemen',
  async function () {
    const persoon = await PersoonFactory.create(this.context, 'Jan');

    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Den Haag',
    );

    await registreerAbonneeVoorAfnemer(afnemer, 'dbz');

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      'jz',
      'nl.brp.verhuisd.intergemeentelijk',
      persoon,
    );
  },
);

When(
  'een abonnee zich abonneert op een ongeldige gebeurtenis van een persoon',
  async function () {
    const persoon = await PersoonFactory.create(this.context, 'Jan');

    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Den Haag',
    );

    await registreerAbonneeVoorAfnemer(afnemer, 'dbz');

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      'dbz',
      'nl.brp.gebeurtenis.ongeldig',
      persoon,
    );
  },
);

When(
  'een abonnee zich abonneert op een gebeurtenis van een persoon met een ongeldig burgerservicenummer',
  async function () {
    const persoon = new Persoon('123456789', '98765432', 'Jansen');

    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Den Haag',
    );

    await registreerAbonneeVoorAfnemer(afnemer, 'dbz');

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      'dbz',
      'nl.brp.verhuisd.intergemeentelijk',
      persoon,
    );
  },
);

When(
  'een abonnee zich abonneert op een gebeurtenis van een persoon die niet is geregistreerd in de BRP',
  async function () {
    const persoon = new Persoon('123456789', '987654321', 'Jansen');

    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Den Haag',
    );

    await registreerAbonneeVoorAfnemer(afnemer, 'dbz');

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      'dbz',
      'nl.brp.verhuisd.intergemeentelijk',
      persoon,
    );
  },
);

When(
  'de abonnee {string} van afnemer {string} zich( weer) abonneert op de {string} gebeurtenissen van {string}',
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

    await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);

    this.result = await abonneerOpGebeurtenistypeVanPersoon(
      afnemer,
      abonneeNaam,
      `nl.brp.${gebeurtenistype}`,
      persoon,
    );
  },
);

When(
  'de abonnee {string} van afnemer {string} zijn abonnement op de {string} gebeurtenissen van {string}( opnieuw) opzegt',
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

    await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);

    this.result = await zegOpAbonnementOpGebeurtenistypeVanPersoon(
      afnemer,
      abonneeNaam,
      `nl.brp.${gebeurtenistype}`,
      persoon,
    );
  },
);

When(
  'de abonnee {string} van afnemer {string} alle abonnementen op de gebeurtenissen van {string} opzegt',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
  ) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await zegOpAbonnementenOpPersoon(
      afnemer,
      abonneeNaam,
      persoon,
    );
  },
);
