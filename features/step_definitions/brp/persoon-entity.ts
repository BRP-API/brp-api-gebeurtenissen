import { Adres } from "./adres-entity";
import { toBrpDate } from "../support/date-utils";

class Verblijfplaats {
    volg_nr: string = '0';
    inschrijving_gemeente_code?: string;
    inschrijving_datum?: string;
    adres_id?: string;
    adres_functie?: string;
    adreshouding_start_datum?: string;
    aangifte_adreshouding_oms?: string;
    geldigheid_start_datum?: string;

    constructor(inschrijving_gemeente_code: string,
                inschrijving_datum: string,
                adres_id: string,
                adreshouding_start_datum: string,
                adres_functie: string = 'W',
                aangifte_adreshouding_oms: string = 'I',
                geldigheid_start_datum?: string) {
        this.inschrijving_gemeente_code = inschrijving_gemeente_code;
        this.inschrijving_datum = inschrijving_datum;
        this.adres_id = adres_id;
        this.adreshouding_start_datum = adreshouding_start_datum;
        this.adres_functie = adres_functie;
        this.aangifte_adreshouding_oms = aangifte_adreshouding_oms;
        this.geldigheid_start_datum = geldigheid_start_datum || inschrijving_datum;
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

    constructor(a_nr?: string|undefined,
                burger_service_nr?: string|undefined) {
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
            this.verblijfplaats = new Verblijfplaats(adres.gemeente_code!.toString(),
                                                     toBrpDate(datum),
                                                     adres.adres_id!.toString(),
                                                     toBrpDate(datum));
    }
}