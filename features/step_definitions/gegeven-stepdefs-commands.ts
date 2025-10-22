import { Given } from '@cucumber/cucumber';
import { Aanduiding } from './support/aanduiding';

Given('de verwerkte opgave van verhuizing van {string}', function (persoonAanduiding: string) {
    this.command.type = 'OpgaveVanVerhuizing';
    this.command.burgerservicenummer = this.context.personen[persoonAanduiding].burger_service_nr;

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
});
