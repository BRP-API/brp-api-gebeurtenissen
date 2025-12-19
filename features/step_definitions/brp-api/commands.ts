export class Command {
    type: string;

    constructor(type: string) {
        this.type = type;
    }
}

export class AangifteVanAdreswijzigingCommand extends Command {
    verhuisdatum?: string;
    burgerservicenummer?: string;
    adresseerbaarObjectIdentificatie?: string;

    constructor(burgerservicenummer: string, adresseerbaarObjectIdentificatie?: string, verhuisdatum?: string) {
        super('AangifteVanAdreswijziging');

        this.burgerservicenummer = burgerservicenummer;
        if(adresseerbaarObjectIdentificatie) {
            this.adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie;
        }
        if(verhuisdatum) {
            this.verhuisdatum = verhuisdatum;
        }
    }
}

export class RegistreerAbonneeCommand extends Command {
    abonneeNaam?: string;

    constructor(abonneeNaam: string) {
        super('RegistreerAbonnee');

        this.abonneeNaam = abonneeNaam;
    }
}

export class AbonneerOpgebeurtenisTypeVanPersoonCommand extends Command {
    abonneeNaam: string;
    gebeurtenisType: string;
    burgerservicenummer: string;

    constructor(abonneeNaam: string, gebeurtenisType: string, burgerservicenummer: string) {
        super('AbonneerOpGebeurtenisTypeVanPersoon');

        this.abonneeNaam = abonneeNaam;
        this.gebeurtenisType = gebeurtenisType;
        this.burgerservicenummer = burgerservicenummer;
    }
}