import { Given } from '@cucumber/cucumber';
import { Persoon } from './brp/persoon-entity';
import { Aanduiding } from './support/aanduiding';

Given('de persoon {string}', function (persoonAanduiding: string) {
    if(!this.context.personen) {
        this.context.personen = {};
    }
    this.context.personen[persoonAanduiding] = new Persoon(undefined, undefined, persoonAanduiding);
    this.huidigAanduiding = Aanduiding.persoon(persoonAanduiding);
});

Given('met A-nummer {string}', function (aNummer: string) {
    if(this.huidigAanduiding?.isPersoon) {
        const persoon = this.context.personen[this.huidigAanduiding.id];
        persoon.a_nr = aNummer;
    }
});

Given('met burgerservicenummer {string}', function (burgerservicenummer: string) {
    if(this.huidigAanduiding?.isPersoon) {
        const persoon = this.context.personen[this.huidigAanduiding.id];
        persoon.burger_service_nr = burgerservicenummer;
    }
});