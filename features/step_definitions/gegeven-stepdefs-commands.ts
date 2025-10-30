import { Given } from '@cucumber/cucumber';
import { Aanduiding } from './support/aanduiding';

Given('de verwerkte aangifte van adreswijziging van {string}', function (persoonAanduiding: string) {
    if(this.command) {
        this.logger.warn(`Er is al een command aanwezig bij het aanmaken van een nieuwe command: ${JSON.stringify(this.command)}`);
    }
    this.command.type = 'AangifteVanAdreswijziging';
    this.command.burgerservicenummer = this.context.personen[persoonAanduiding].burger_service_nr;

    this.huidigAanduiding = Aanduiding.command(persoonAanduiding);
});
