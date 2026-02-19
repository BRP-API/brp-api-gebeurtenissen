import { Then } from '@cucumber/cucumber';
import { CloudEvent } from './support/cloud-events';
import { setNestedProperty } from './support/object-utils';
import { Aanduiding } from './support/aanduiding';
import { VerhuisdIntergemeentelijkEvent } from './brp/verhuisd-intergemeentelijk-event';
import { AangifteVanAdreswijzigingCommand } from './brp-api/commands';
import { Persoon } from './brp/persoon-entity';

Then('zijn er geen gebeurtenissen gepubliceerd', function () {
});

function getPersoonByBsn(personen: any, bsn: string) : Persoon | undefined {
    const key = Object.keys(personen).find(key => {
        return personen[key].burger_service_nr === bsn;
    });
    return key ? personen[key] : undefined;
}

Then('is een {string} gebeurtenis gepubliceerd( met de volgende velden)( met de volgende data)', function (gebeurtenisType: string) {
    this.expected = gebeurtenisType === 'verhuisd.intergemeentelijk' ? new VerhuisdIntergemeentelijkEvent(true) : new CloudEvent(`nl.brp.${gebeurtenisType}`);
    this.aanduiding = Aanduiding.gepubliceerdGebeurtenis();

    if(this.command instanceof AangifteVanAdreswijzigingCommand) {
        const persoon: Persoon | undefined = getPersoonByBsn(this.context.personen, this.command.burgerservicenummer!);
        if(persoon) {
            this.expected.setAnummer(persoon.a_nr);
        }
        this.expected.setVerhuisdatum(this.command.verhuisdatum);
        this.expected.setAdresseerbaarObjectIdentificatie(this.command.adresseerbaarObjectIdentificatie);
    }
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
