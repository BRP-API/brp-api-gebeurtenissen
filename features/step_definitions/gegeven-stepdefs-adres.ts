import { Given } from '@cucumber/cucumber';
import { Adres } from './brp/adres-entity';
import { Aanduiding } from './support/aanduiding';
import { AdresBuitenland } from './brp/adres-buitenland-entity';
import { Afnemer } from './brp/afnemer-entity';

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
        (this.context.adressen[this.huidigAanduiding.id] as Adres).gemeente_code = gemeenteCodeMap[gemeenteOmschrijving] || gemeenteOmschrijving;
    }
    if(this.huidigAanduiding?.isAfnemer) {
        (this.context.afnemers[this.huidigAanduiding.id] as Afnemer).gemeenteCode = gemeenteCodeMap[gemeenteOmschrijving] || gemeenteOmschrijving;
    }
});

Given('met adresseerbaar object identificatie {string}', function (adresseerbaarObjectIdentificatie:string) {
    if(this.huidigAanduiding?.isAdres) {
        (this.context.adressen[this.huidigAanduiding.id] as Adres).verblijf_plaats_ident_code = adresseerbaarObjectIdentificatie;
    }
});

Given('met de functie {string}', function (adresfunctie: string) {
    const functieMap: {[key: string]: string} = {
        'woonadres': 'W',
        'briefadres': 'B'
    };

    if(this.huidigAanduiding?.isAdres) {
        (this.context.adressen[this.huidigAanduiding.id] as Adres).adres_functie = functieMap[adresfunctie] || adresfunctie;
    }
});

Given('het adres buitenland {string}', function (adresAanduiding: string) {
    if(!this.context.adressen) {
        this.context.adressen = {};
    }
    this.context.adressen[adresAanduiding] = new AdresBuitenland();
    this.huidigAanduiding = Aanduiding.adresBuitenland(adresAanduiding);
});

Given('met adres regel 1 {string}', function (adresRegel1: string) {
    if(this.huidigAanduiding?.isAdresBuitenland) {
        (this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland).vertrek_land_adres_1 = adresRegel1;
    }
});

Given('met adres regel 2 {string}', function (adresRegel2: string) {
    if(this.huidigAanduiding?.isAdresBuitenland) {
        (this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland).vertrek_land_adres_2 = adresRegel2;
    }
});

Given('met adres regel 3 {string}', function (adresRegel3: string) {
    if(this.huidigAanduiding?.isAdresBuitenland) {
        (this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland).vertrek_land_adres_3 = adresRegel3;
    }
});

Given('in land {string}', function (landCode: string) {
    const landCodeMap: {[key: string]: string} = {
        'Frankrijk': '5002',
        'Zwitserland': '5003',
        'België': '5010',
        'Verenigde Staten van Amerika': '6014',
        'Duitsland': '6029',
        'Onbekend': '0000',
    };

    if(this.huidigAanduiding?.isAdresBuitenland) {
        (this.context.adressen[this.huidigAanduiding.id] as AdresBuitenland).vertrek_land_code = landCodeMap[landCode] || landCode;
    }
});