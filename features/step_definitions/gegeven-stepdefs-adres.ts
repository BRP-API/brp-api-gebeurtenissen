import { Given } from '@cucumber/cucumber';
import { Adres } from './brp/adres-entity';
import { Aanduiding } from './support/aanduiding';

Given('het adres {string}', function (adresAanduiding: string) {
    if(!this.context.adressen) {
        this.context.adressen = {};
    }
    this.context.adressen[adresAanduiding] = new Adres();
    this.huidigAanduiding = Aanduiding.adres(adresAanduiding);
});

Given('in gemeente {string}', function (gemeenteOmschrijving: string) {
    const gemeenteCodeMap: {[key: string]: string} = {
        'Amsterdam': '0363',
        'Den Haag': '0518',
        'Hengelo': '0164',
        'Roosendaal': '1674',
        'Rotterdam': '0599',
        'Utrecht': '0344',
    };

    if(this.huidigAanduiding?.isAdres) {
        this.context.adressen[this.huidigAanduiding.id].gemeente_code = gemeenteCodeMap[gemeenteOmschrijving] || gemeenteOmschrijving;
    }
});

Given('met adresseerbaar object identificatie {string}', function (adresseerbaarObjectIdentificatie:string) {
    if(this.huidigAanduiding?.isAdres) {
        this.context.adressen[this.huidigAanduiding.id].verblijf_plaats_ident_code = adresseerbaarObjectIdentificatie;
    }
});
