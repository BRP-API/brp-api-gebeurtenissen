import { Given } from '@cucumber/cucumber';
import { logger } from './support/logger';
import { AbonneerOpgebeurtenisTypeVanPersoonCommand, RegistreerAbonneeCommand } from "./brp-api/commands";
import { abonneerOpgebeurtenisTypeVanPersoon, registreerAbonnee } from "./support/abonnement-api-helpers";

Given('is niet geregistreerd als abonnee van BRP API Gebeurtenissen', function () {
});

Given('is geregistreerd als abonnee van BRP API Gebeurtenissen', function () {
});

Given('is geregistreerd als abonnee {string} van BRP API Gebeurtenissen', async function (abonneeNaam: string) {
    this.context.abonnees = this.context.abonnees || {};
    this.context.abonnees[abonneeNaam] = abonneeNaam;

    const afnemer = this.context.afnemers[this.huidigAanduiding.id];
    const command = new RegistreerAbonneeCommand(abonneeNaam);

    this.context.result = await registreerAbonnee(afnemer, command);
});

Given('de abonnee {string} is geabonneerd op {string} gebeurtenissen van de persoon {string}', async function (abonneeNaam: string, afnemerAanduiding: string, gebeurtenisTypeAanduiding: string, persoonAanduiding: string) {
    this.context.abonnees = this.context.abonnees || {};
    this.context.abonnees[abonneeNaam] = abonneeNaam;

    const gebeurtenisType = this.context.gebeurtenisTypes[gebeurtenisTypeAanduiding];
    const persoon = this.context.personen[persoonAanduiding];
    const command = new AbonneerOpgebeurtenisTypeVanPersoonCommand( abonneeNaam, gebeurtenisType, persoon.burger_service_nr);
    const afnemer = this.context.afnemers[afnemerAanduiding];

    this.context.result = await abonneerOpgebeurtenisTypeVanPersoon(afnemer, command);
});
