import { When } from '@cucumber/cucumber';
import { Aanduiding } from './support/aanduiding';
import { AangifteVanAdreswijzigingCommand } from './brp-api/commands';

When('de aangifte van adreswijziging van {string} is verwerkt', function (persoonAanduiding: string) {
    this.command = new AangifteVanAdreswijzigingCommand(this.context.personen[persoonAanduiding].burger_service_nr);

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
});

When('de aangifte van vertrek naar het buitenland van {string} is verwerkt', function (persoonAanduiding: string) {
    this.command.type = 'AangifteVanVertrek';
    this.command.burgerservicenummer = this.context.personen[persoonAanduiding].burger_service_nr;

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
});