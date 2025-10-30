import { Adres } from "./adres-entity";
import { toBrpDate } from "../support/date-utils";

class Verblijfplaats {
    private adres: Adres;
    volg_nr: string = '0';
    inschrijving_datum?: string;
    adres_functie?: string;
    adreshouding_start_datum?: string;
    aangifte_adreshouding_oms?: string;
    geldigheid_start_datum?: string;

    constructor(adres: Adres,
                adreshouding_start_datum: string) {
        this.adres = adres;
        this.inschrijving_datum = adreshouding_start_datum;
        this.adreshouding_start_datum = adreshouding_start_datum;
        this.adres_functie = 'W';
        this.aangifte_adreshouding_oms = 'I';
        this.geldigheid_start_datum = adreshouding_start_datum;
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
            'geldigheid_start_datum'
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
            geldigheid_start_datum: this.geldigheid_start_datum
        };
    }
}

export class Persoon {
    pl_id?: string;
    persoon_type: string = 'P';
    stapel_nr: string = '0';
    volg_nr: string = '0';
    a_nr?: string;
    burger_service_nr?: string;
    geheim_ind: string = '0';
    verblijfplaats?: Verblijfplaats;

    constructor(a_nr?: string,
                burger_service_nr?: string) {
        if(a_nr) this.a_nr = a_nr;
        if(burger_service_nr) this.burger_service_nr = burger_service_nr;
    }

    getPropertyNames(): string[] {
        return [
            'pl_id',
            'persoon_type',
            'stapel_nr',
            'volg_nr',
            'a_nr',
            'burger_service_nr',
            'geheim_ind'
        ];
    }

    verhuistNaarAdres(adres: Adres, datum: string): void {
            this.verblijfplaats = new Verblijfplaats(adres,
                                                     toBrpDate(datum));
    }
}