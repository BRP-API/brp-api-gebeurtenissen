import { When } from '@cucumber/cucumber';
import { Aanduiding } from './support/aanduiding';

When('de aangifte van adreswijziging van {string} is verwerkt', function (persoonAanduiding: string) {
    this.command.type = 'AangifteVanAdreswijziging';
    this.command.burgerservicenummer = this.context.personen[persoonAanduiding].burger_service_nr;

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
});
