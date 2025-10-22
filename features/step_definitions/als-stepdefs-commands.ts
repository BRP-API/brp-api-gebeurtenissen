import { When } from '@cucumber/cucumber';
import { Aanduiding } from './support/aanduiding';

When('de opgave van verhuizing van {string} is verwerkt', function (persoonAanduiding: string) {
    this.command.type = 'OpgaveVanVerhuizing';
    this.command.burgerservicenummer = this.context.personen[persoonAanduiding].burger_service_nr;

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
});
