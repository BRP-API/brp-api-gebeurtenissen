import { Given } from '@cucumber/cucumber';
import { AfnemerFactory } from './support/afnemer-factory';
import {
    abonneerOpGebeurtenistypeVanPersoon,
    deregistreerAbonneeVoorAfnemer,
    registreerAbonneeVoorAfnemer,
    verwijderGroepVanAbonnee,
    voegGebeurtenistypeToeAanGroep,
    voegGroepToeBijAbonnee,
    zegOpAbonnementOpGebeurtenistypeVanPersoon
} from './support/abonnement-api-helpers';
import { createObjectArrayFrom, createObjectFrom } from './support/dataTable2Object';

Given('de afnemer {string} heeft de abonnee {string} geregistreerd', async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
});

Given('de afnemer {string} heeft de abonnee {string} gederegistreerd', async function (afnemerAanduiding: string, abonneeNaam: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await deregistreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
});

Given('de afnemer {string} heeft bij de abonnee {string} de groep {string} toegevoegd', async function (afnemerAanduiding: string, abonneeNaam: string, groepNaam: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await voegGroepToeBijAbonnee(afnemer, abonneeNaam, groepNaam);
});

Given('de afnemer {string} heeft bij de abonnee {string} de groep {string}', async function (afnemerAanduiding: string, abonneeNaam: string, groepNaam: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await voegGroepToeBijAbonnee(afnemer, abonneeNaam, groepNaam);
});

Given('de afnemer {string} heeft bij de abonnee {string} de groep {string} verwijderd', async function (afnemerAanduiding: string, abonneeNaam: string, groepNaam: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await verwijderGroepVanAbonnee(afnemer, abonneeNaam, groepNaam);
});

Given('de afnemer {string} heeft bij de abonnee {string} het gebeurtenistype {string} aan de groep {string} toegevoegd', async function (afnemerAanduiding: string, abonneeNaam: string, gebeurtenistype: string, groepNaam: string) {
    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    this.result = await voegGebeurtenistypeToeAanGroep(afnemer, abonneeNaam, groepNaam, gebeurtenistype);
});

Given('is niet geregistreerd als abonnee van BRP API Gebeurtenissen', function () {
});

Given('is geregistreerd als abonnee van BRP API Gebeurtenissen', function () {
});

Given('er is een {string} gebeurtenis gepubliceerd met de volgende velden', async function (gebeurtenisType, dataTable) {
    const gebeurtenis = createObjectFrom(dataTable);

    const afnemer = await AfnemerFactory.create(this.context, gebeurtenis.afnemerId);

    switch (gebeurtenisType) {
        case 'AbonneeGeregistreerd':
            this.result = await registreerAbonneeVoorAfnemer(afnemer, gebeurtenis.abonneeNaam);
            break;
        case 'AbonneeGederegistreerd':
            this.result = await deregistreerAbonneeVoorAfnemer(afnemer, gebeurtenis.abonneeNaam);
            break;
        default:
            throw new Error(`Onbekend gebeurtenisType: ${gebeurtenisType}`);
    }
});

Given('de volgende {string} gebeurtenissen zijn gepubliceerd', async function (gebeurtenisType, dataTable) {
    if (gebeurtenisType === 'AbonneeGeregistreerd') {
        const gebeurtenissen = createObjectArrayFrom(dataTable);

        for (const gebeurtenis of gebeurtenissen) {
            const afnemer = await AfnemerFactory.create(this.context, gebeurtenis.afnemerId);

            this.result = await registreerAbonneeVoorAfnemer(afnemer, gebeurtenis.abonneeNaam);
        }
    }
});

Given('de abonnee {string} van afnemer {string} heeft zich geabonneerd op de {string} gebeurtenissen van {string}', async function (abonneeNaam, afnemerAanduiding, gebeurtenistype, persoonAanduiding) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    if (!afnemer.abonnees.includes(abonneeNaam)) {
        await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    }

    this.result = await abonneerOpGebeurtenistypeVanPersoon(afnemer, abonneeNaam, `nl.brp.${gebeurtenistype}`, persoon);
});

Given('de abonnee {string} van afnemer {string} heeft zijn abonnement op de {string} gebeurtenissen van {string} opgezegd', async function (abonneeNaam, afnemerAanduiding, gebeurtenistype, persoonAanduiding) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    if (!afnemer.abonnees.includes(abonneeNaam)) {
        await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    }

    this.result = await zegOpAbonnementOpGebeurtenistypeVanPersoon(afnemer, abonneeNaam, `nl.brp.${gebeurtenistype}`, persoon);
});

Given('de abonnee {string} van afnemer {string} heeft een abonnement op de {string} gebeurtenissen van {string}', async function (abonneeNaam: string, afnemerAanduiding: string, gebeurtenistype: string, persoonAanduiding: string) {
    const persoon = this.context.personen[persoonAanduiding];

    const afnemer = await AfnemerFactory.create(this.context, afnemerAanduiding);

    if (!afnemer.abonnees.includes(abonneeNaam)) {
        await registreerAbonneeVoorAfnemer(afnemer, abonneeNaam);
    }

    this.result = await abonneerOpGebeurtenistypeVanPersoon(afnemer, abonneeNaam, `nl.brp.${gebeurtenistype}`, persoon);
});
