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
