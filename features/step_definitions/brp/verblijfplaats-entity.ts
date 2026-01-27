import { AdresBuitenland } from './adres-buitenland-entity';
import { Adres } from './adres-entity';

export abstract class Verblijfplaats {
  volg_nr: string;
  geldigheid_start_datum?: string;

  constructor(volg_nr: string, geldigheid_start_datum?: string) {
    this.volg_nr = volg_nr;

    if (geldigheid_start_datum) this.geldigheid_start_datum = geldigheid_start_datum;
  }

  abstract getPropertyNames(): string[];
  abstract getClone(): any;
}

export class VerblijfplaatsBinnenland extends Verblijfplaats {
  private readonly adres: Adres;
  inschrijving_datum?: string;
  adres_functie?: string;
  adreshouding_start_datum?: string;
  aangifte_adreshouding_oms?: string;

  constructor(adres: Adres, adreshouding_start_datum: string) {
    super('0', adreshouding_start_datum);

    this.adres = adres;
    this.inschrijving_datum = adreshouding_start_datum;
    this.adreshouding_start_datum = adreshouding_start_datum;
    this.adres_functie = 'W';
    this.aangifte_adreshouding_oms = 'I';
  }

  get adres_id(): string | undefined {
    return this.adres.adres_id?.toString();
  }

  get inschrijving_gemeente_code(): string | undefined {
    return this.adres.gemeente_code?.toString();
  }

  getPropertyNames(): string[] {
    return [
      'volg_nr',
      'inschrijving_gemeente_code',
      'inschrijving_datum',
      'adres_id',
      'adres_functie',
      'adreshouding_start_datum',
      'aangifte_adreshouding_oms',
      'geldigheid_start_datum',
    ];
  }

  getClone(): any {
    return {
      volg_nr: this.volg_nr,
      inschrijving_gemeente_code: this.inschrijving_gemeente_code,
      inschrijving_datum: this.inschrijving_datum,
      adres_id: this.adres_id,
      adres_functie: this.adres_functie,
      adreshouding_start_datum: this.adreshouding_start_datum,
      aangifte_adreshouding_oms: this.aangifte_adreshouding_oms,
      geldigheid_start_datum: this.geldigheid_start_datum,
    };
  }
}

export class VerblijfplaatsBuitenland extends Verblijfplaats {
  private readonly adres: AdresBuitenland;
  vertrek_datum?: string;

  constructor(adres: AdresBuitenland, vertrek_datum: string) {
    super('0', vertrek_datum);

    this.adres = adres;
    this.vertrek_datum = vertrek_datum;
  }

  getPropertyNames(): string[] {
    return [
      'volg_nr',
      'vertrek_datum',
      'vertrek_land_adres_1',
      'vertrek_land_adres_2',
      'vertrek_land_adres_3',
      'vertrek_land_code',
      'geldigheid_start_datum',
    ];
  }

  getClone(): any {
    return {
      volg_nr: this.volg_nr,
      vertrek_datum: this.vertrek_datum,
      vertrek_land_adres_1: this.adres.vertrek_land_adres_1,
      vertrek_land_adres_2: this.adres.vertrek_land_adres_2,
      vertrek_land_adres_3: this.adres.vertrek_land_adres_3,
      vertrek_land_code: this.adres.vertrek_land_code,
      geldigheid_start_datum: this.geldigheid_start_datum,
    };
  }
}
