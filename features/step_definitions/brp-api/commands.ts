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

  constructor(
    burgerservicenummer: string,
    adresseerbaarObjectIdentificatie?: string,
    verhuisdatum?: string,
  ) {
    super('AangifteVanAdreswijziging');

    this.burgerservicenummer = burgerservicenummer;
    if (adresseerbaarObjectIdentificatie) {
      this.adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie;
    }
    if (verhuisdatum) {
      this.verhuisdatum = verhuisdatum;
    }
  }
}

export class AangifteVanVertrekNaarBuitenlandCommand extends Command {
  burgerservicenummer: string;
  landCode: string;
  datumEmigratie: string;
  regel1?: string;
  regel2?: string;
  regel3?: string;

  constructor(
    burgerservicenummer: string,
    landCode: string,
    datumEmigratie: string,
    regel1?: string,
    regel2?: string,
    regel3?: string,
  ) {
    super('AangifteVanVertrekNaarBuitenland');
    this.burgerservicenummer = burgerservicenummer;
    this.regel1 = regel1;
    this.regel2 = regel2;
    this.regel3 = regel3;
    this.landCode = landCode;
    this.datumEmigratie = datumEmigratie;
  }
}
