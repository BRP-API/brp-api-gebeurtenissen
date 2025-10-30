import { Then } from '@cucumber/cucumber';
import { CloudEvent } from './support/cloud-events';
import { setNestedProperty } from './support/object-utils';
import { Aanduiding } from './support/aanduiding';
import { VerhuisdIntergemeentelijkEvent } from './brp/verhuisd-intergemeentelijk-event';

Then('zijn er geen gebeurtenissen gepubliceerd', function () {
});

Then('is een {string} gebeurtenis gepubliceerd( met de volgende velden)( met de volgende data)', function (gebeurtenisType: string) {
    this.expected = gebeurtenisType === 'verhuisd.intergemeentelijk' ? new VerhuisdIntergemeentelijkEvent(true) : new CloudEvent(`nl.brp.${gebeurtenisType}`);
    this.aanduiding = Aanduiding.gepubliceerdGebeurtenis();
});

Then('is een {string} gebeurtenis geleverd( met de volgende velden)( met de volgende data)', function (gebeurtenisType: string) {
    this.expected = gebeurtenisType === 'verhuisd.intergemeentelijk' ? new VerhuisdIntergemeentelijkEvent(false) : new CloudEvent(`nl.brp.${gebeurtenisType}`);
});

Then('{string} met de afnemer id van {string}', function (veld: string, aanduidingAfnemer: string) {
    setNestedProperty(this.expected, `data.${veld}`, aanduidingAfnemer);
});

Then('het A-nummer van {string}', function (aanduidingPersoon: string) {
    if(this.expected instanceof VerhuisdIntergemeentelijkEvent) {
        this.expected.setAnummer(this.context.personen[aanduidingPersoon].a_nr);
    }
});

Then('de vanaf datum van de opgave van verhuizing van {string}', function (persoonAanduiding: string) {
    if(this.expected instanceof VerhuisdIntergemeentelijkEvent) {
        this.expected.setVerhuisdatum(this.command.verhuisdatum);
        return;
    }
});

Then('de adresseerbaar object identificatie van het adres {string}', function (adresAanduiding: string) {
    if(this.expected instanceof VerhuisdIntergemeentelijkEvent) {
        this.expected.setAdresseerbaarObjectIdentificatie(this.context.adressen[adresAanduiding].verblijf_plaats_ident_code);
    }
});

Then('het burgerservicenummer van {string}', function (aanduidingPersoon: string) {
    if(this.expected instanceof VerhuisdIntergemeentelijkEvent) {
        this.expected.setBurgerservicenummer(this.context.personen[aanduidingPersoon].burger_service_nr);
    }
});
