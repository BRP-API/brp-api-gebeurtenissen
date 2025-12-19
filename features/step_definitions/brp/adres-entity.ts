export class Adres {
    adres_id?: number;
    gemeente_code?: string;
    verblijf_plaats_ident_code?: string;
    adres_functie?: string;

    constructor(gemeente_code?: string,
                verblijf_plaats_ident_code?: string,
                adres_functie?: string) {
        if(gemeente_code) this.gemeente_code = gemeente_code;
        if(verblijf_plaats_ident_code) this.verblijf_plaats_ident_code = verblijf_plaats_ident_code;
        if(adres_functie) this.adres_functie = adres_functie;
    }

    getPropertyNames(): string[] {
        return [
            'adres_id',
            'gemeente_code',
            'verblijf_plaats_ident_code',
            'adres_functie'
        ];
    }
}