import { Adres } from "./adres-entity";
import { Persoon } from "./persoon-entity";
import { toBrpApiDatum } from '../support/date-utils';

class VerhuisdIntergemeentelijkData {
    burgerservicenummer?: string;
    adresseerbaarObjectIdentificatie?: string;
    datumVan?: any;

    constructor(persoon?: Persoon, adres?: Adres, verhuisdatum?: string) {
        this.burgerservicenummer = persoon?.burger_service_nr;
        this.adresseerbaarObjectIdentificatie = adres?.verblijf_plaats_ident_code;
        this.datumVan = verhuisdatum;
    }
}

class G01 {
    e0110?: string

    constructor(anummer?: string) {
        this.e0110 = anummer;
    }
}

class G10 {
    e1030?: string;

    constructor(verhuisdatum?: string) {
        this.e1030 = verhuisdatum;
    }
}

class G11 {
    e1180?: string;

    constructor(adres?: Adres) {
        this.e1180 = adres?.verblijf_plaats_ident_code;
    }
}

class C01 {
    g01: G01;

    constructor(persoon?: Persoon) {
        this.g01 = new G01(persoon?.a_nr);
    }
}

class C08 {
    g10: G10;
    g11: G11;

    constructor(adres?: Adres, verhuisdatum?: string) {
        this.g10 = new G10(verhuisdatum);
        this.g11 = new G11(adres);
    }
}

class VerhuisdIntergemeentelijkInternData {
    c01: C01;
    c08: C08;

    constructor(persoon?: Persoon, adres?: Adres, verhuisdatum?: string) {
        this.c01 = new C01(persoon);
        this.c08 = new C08(adres, verhuisdatum);
    }
}

// VerhuisdIntergemeentelijkEvent tbv makkelijker instantiëren van interne en externe varianten
export class VerhuisdIntergemeentelijkEvent {
    type: string;
    data: VerhuisdIntergemeentelijkInternData | VerhuisdIntergemeentelijkData;

    constructor(intern: boolean, persoon?: Persoon, adres?: Adres, verhuisdatum?: string) {
        this.type = 'nl.brp.verhuisd.intergemeentelijk';
        if(intern) {
            this.data = new VerhuisdIntergemeentelijkInternData(persoon, adres, verhuisdatum);
        } else {
            this.data = new VerhuisdIntergemeentelijkData(persoon, adres, verhuisdatum);
        }
    }

    setAnummer(anummer: string) {
        if(this.data instanceof VerhuisdIntergemeentelijkInternData) {
            this.data.c01.g01.e0110 = anummer;
        }
    }

    setBurgerservicenummer(burgerservicenummer: string) {
        if(this.data instanceof VerhuisdIntergemeentelijkData) {
            this.data.burgerservicenummer = burgerservicenummer;
        }
    }

    setAdresseerbaarObjectIdentificatie(adoId: string) {
        if(this.data instanceof VerhuisdIntergemeentelijkData) {
            this.data.adresseerbaarObjectIdentificatie = adoId;
        }
        else if(this.data instanceof VerhuisdIntergemeentelijkInternData) {
            this.data.c08.g11.e1180 = adoId;
        }
    }

    setVerhuisdatum(datum: string) {
        const date = datum.replace(/-/g, '');

        if(this.data instanceof VerhuisdIntergemeentelijkData) {
            this.data.datumVan = toBrpApiDatum(date);
        }
        else if(this.data instanceof VerhuisdIntergemeentelijkInternData) {
            this.data.c08.g10.e1030 = date;
        }
    }
}
