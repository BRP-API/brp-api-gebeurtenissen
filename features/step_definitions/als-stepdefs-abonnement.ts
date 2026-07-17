import {When} from '@cucumber/cucumber';
import {
  //abonneerOpGebeurtenistypeVanPersoon,
  abonneerPersoonOpGroep,
  deregistreerAbonneeVoorAfnemer,
  raadpleegAbonneesVoorAfnemer,
  raadpleegAbonnementen,
  raadpleegGebeurtenistypesInGroep,
  raadpleegGroepenVanAbonnee,
  registreerAbonneeVoorAfnemer,
  verwijderGebeurtenistypeUitGroep,
  verwijderGroepVanAbonnee,
  voegGebeurtenistypeToeAanGroep,
  voegGroepToeBijAbonnee,
  // zegOpAbonnementenOpPersoon,
  // zegOpAbonnementOpGebeurtenistypeVanPersoon
} from './support/abonnement-api-helpers';
import {AfnemerFactory} from './support/afnemer-factory';
import {PersoonFactory} from './support/persoon-factory';
//import {Persoon} from './brp/persoon-entity';

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
  'de afnemer {string} een abonnee registreert zonder een naam voor de abonnee op te geven',
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

    const response = await voegGroepToeBijAbonnee(afnemer, abonneeNaam, groepNaam);
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
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

    const response = await verwijderGroepVanAbonnee(
      afnemer,
      abonneeNaam,
      groepNaam,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
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

    const response = await voegGebeurtenistypeToeAanGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      gebeurtenistype,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
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

    const response = await verwijderGebeurtenistypeUitGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      gebeurtenistype,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
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

    const response = await raadpleegGebeurtenistypesInGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zich abonneert op de persoon {string} voor de groep {string}',
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

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'AbonneerPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zich abonneert voor persoon {string} en groep {string} zonder type op te geven',
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

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zich abonneert voor persoon {string} en groep {string} met type {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
    groepNaam: string,
    type: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      type,
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zich abonneert op de persoon met burgerservicenummer {string} voor de groep {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    burgerservicenummer: string,
    groepNaam: string,
  ) {
    const persoon = await PersoonFactory.create(this.context, 'Jan');
    persoon.burger_service_nr = burgerservicenummer;

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'AbonneerPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zich abonneert voor de groep {string} zonder een burgerservicenummer op te geven',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    groepNaam: string,
  ) {
    const persoon = await PersoonFactory.create(this.context, 'Jan');
    delete persoon.burger_service_nr;

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'AbonneerPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zich abonneert op de persoon {string} zonder een groep op te geven',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      '',
      persoon,
      'AbonneerPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zijn abonnement op de persoon {string} voor de groep {string} opzegt',
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

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'ZegOpAbonnementVanPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} een abonnement voor de groep {string} opzegt zonder een burgerservicenummer op te geven',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    groepNaam: string,
  ) {
    const persoon = await PersoonFactory.create(this.context, 'Jan');
    delete persoon.burger_service_nr;

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'ZegOpAbonnementVanPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zijn abonnement op de persoon met burgerservicenummer {string} voor de groep {string} opzegt',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    burgerservicenummer: string,
    groepNaam: string,
  ) {
    const persoon = await PersoonFactory.create(this.context, 'Jan');
    persoon.burger_service_nr = burgerservicenummer;

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      groepNaam,
      persoon,
      'ZegOpAbonnementVanPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'de abonnee {string} van afnemer {string} zijn abonnement op de persoon {string} opzegt zonder een groep op te geven',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
  ) {
    const persoon = await PersoonFactory.create(
      this.context,
      persoonAanduiding,
    );

    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const response = await abonneerPersoonOpGroep(
      afnemer,
      abonneeNaam,
      '',
      persoon,
      'ZegOpAbonnementVanPersoonOpGroep',
    );
    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'abonnee {string} van afnemer {string} de abonnementen opvraagt',
  async function (abonneeNaam: string, afnemerAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegAbonnementen(afnemer, abonneeNaam);
  },
);

When(
  'abonnee {string} van afnemer {string} de abonnementen opvraagt na het abonnement op {string} voor de groep {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    persoonAanduiding: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const persoon = this.context.personen[persoonAanduiding];

    this.result = await raadpleegAbonnementen(
      afnemer,
      abonneeNaam,
      undefined,
      groepNaam,
      persoon,
    );
  },
);

When(
  'abonnee {string} van afnemer {string} maximaal {int} abonnement(en) opvraagt',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    aantal: bigint,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegAbonnementen(afnemer, abonneeNaam, aantal);
  },
);

When(
  'abonnee {string} van afnemer {string} maximaal {int} abonnement opvraagt na het abonnement op {string} voor de groep {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    aantal: bigint,
    persoonAanduiding: string,
    groepNaam: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    const persoon = this.context.personen[persoonAanduiding];

    this.result = await raadpleegAbonnementen(
      afnemer,
      abonneeNaam,
      aantal,
      groepNaam,
      persoon,
    );
  },
);

When(
  'abonnee {string} van afnemer {string} de abonnementen opvraagt met cursor {string}',
  async function (
    abonneeNaam: string,
    afnemerAanduiding: string,
    cursor: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      afnemerAanduiding,
    );

    this.result = await raadpleegAbonnementen(
      afnemer,
      abonneeNaam,
      undefined,
      undefined,
      undefined,
      cursor,
    );
  },
);
