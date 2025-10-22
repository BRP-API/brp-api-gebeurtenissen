import { Given } from '@cucumber/cucumber';
import { toIsoDate } from './support/date-utils';

Given('verblijft vanaf {string} op het adres {string}', function (datum: string, adresAanduiding: string) {
    if(this.huidigAanduiding?.isPersoon) {
        const persoon = this.context.personen[this.huidigAanduiding.id];
        const adres = this.context.adressen[adresAanduiding];

        persoon.verhuistNaarAdres(adres, datum);
    }
    else if(this.huidigAanduiding?.isCommand) {
        this.command.adresseerbaarObjectIdentificatie = this.context.adressen[adresAanduiding].verblijf_plaats_ident_code;
        this.command.verhuisdatum = toIsoDate(datum);
    }
});
