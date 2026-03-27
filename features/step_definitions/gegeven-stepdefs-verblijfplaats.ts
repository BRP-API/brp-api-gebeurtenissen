import { Given } from '@cucumber/cucumber';
import { toIsoDate } from './support/date-utils';
import { Adres } from './brp/adres-entity';
import { AdresBuitenland } from './brp/adres-buitenland-entity';

function handleVerhuizing(persoon: any, adres: any, datum: string) {
    if(adres instanceof Adres) {
        persoon.verhuistNaarAdres(adres, datum);
    }
    if(adres instanceof AdresBuitenland) {
        persoon.verhuistNaarAdresBuitenland(adres, datum);
    }
}

function handleAangifteVanAdreswijzigingCommand(command: any, adres: Adres, datum: string) {
    command.adresseerbaarObjectIdentificatie = adres.verblijf_plaats_ident_code;
    command.verhuisdatum = toIsoDate(datum);
}

function handleAangifteVanVertrekCommand(command: any, adres: AdresBuitenland, datum: string) {
    command.adres = {};
    
    if(adres.vertrek_land_adres_1) {
        command.adres.regel1 = adres.vertrek_land_adres_1;
    }
    if(adres.vertrek_land_adres_2) {
        command.adres.regel2 = adres.vertrek_land_adres_2;
    }
    if(adres.vertrek_land_adres_3) {
        command.adres.regel3 = adres.vertrek_land_adres_3;
    }
    command.adres.land = adres.vertrek_land_code;
    command.verhuisdatum = toIsoDate(datum);
}

Given('verblijft vanaf {string} op het adres {string}', function (datum: string, adresAanduiding: string) {
    if(this.huidigAanduiding?.isPersoon) {
        const persoon = this.context.personen[this.huidigAanduiding.id];
        const adres = this.context.adressen[adresAanduiding];

        handleVerhuizing(persoon, adres, datum);
    }
    else if(this.huidigAanduiding?.isCommand) {
        if(this.command.type === 'AangifteVanAdreswijziging') {
            const adres = this.context.adressen[adresAanduiding] as Adres;
            handleAangifteVanAdreswijzigingCommand(this.command, adres, datum);
        }
        else if (this.command.type === 'AangifteVanVertrek') {
            const adres = this.context.adressen[adresAanduiding] as AdresBuitenland;
            handleAangifteVanVertrekCommand(this.command, adres, datum);
        }
    }
});
