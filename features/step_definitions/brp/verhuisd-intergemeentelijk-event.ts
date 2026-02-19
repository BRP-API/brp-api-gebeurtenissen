import { Adres } from "./adres-entity";
import { Persoon } from "./persoon-entity";
import { toBrpApiDatum } from '../support/date-utils';

class VerhuisdIntergemeentelijkAdresData {
    adresseerbaarObjectIdentificatie?: string;
    datumVan?: any;
}

class VerhuisdIntergemeentelijkData {
    burgerservicenummer?: string;
    verblijfplaats: VerhuisdIntergemeentelijkAdresData;

    constructor(persoon?: Persoon, adres?: Adres, verhuisdatum?: string) {
        this.verblijfplaats = new VerhuisdIntergemeentelijkAdresData();
        this.burgerservicenummer = persoon?.burger_service_nr;
        this.verblijfplaats.datumVan = verhuisdatum;
    }
}

class C01 {
    e0110?: string

    constructor(persoon?: Persoon) {
        this.e0110 = persoon?.a_nr;
    }
}

class C08 {
    e1030?: string;
    e1180?: string;

    constructor(adres?: Adres, verhuisdatum?: string) {
        this.e1030 = verhuisdatum;
        this.e1180 = adres?.verblijf_plaats_ident_code;
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

export class Event {
    type: string;
    id?: string;
    source?: string;
    specversion?: string;

    constructor(intern: boolean, type: string) {
        this.type = type;

        if(!intern) {
            this.source = 'brp';
            this.specversion = '1.0.2';
        }
    }

    get intern(): boolean {
        return this.specversion === undefined;
    }
}

// VerhuisdIntergemeentelijkEvent tbv makkelijker instantiëren van interne en externe varianten
export class VerhuisdIntergemeentelijkEvent extends Event {
    data: VerhuisdIntergemeentelijkInternData | VerhuisdIntergemeentelijkData;

    constructor(intern: boolean, persoon?: Persoon, adres?: Adres, verhuisdatum?: string) {
        super(intern, 'nl.brp.verhuisd.intergemeentelijk');

        if(this.intern) {
            this.data = new VerhuisdIntergemeentelijkInternData(persoon, adres, verhuisdatum);
        } else {
            this.data = new VerhuisdIntergemeentelijkData(persoon, adres, verhuisdatum);
        }
    }

    setAnummer(anummer: string) {
        if(this.data instanceof VerhuisdIntergemeentelijkInternData) {
            this.data.c01.e0110 = anummer;
        }
    }

    setBurgerservicenummer(burgerservicenummer: string) {
        if(this.data instanceof VerhuisdIntergemeentelijkData) {
            this.data.burgerservicenummer = burgerservicenummer;
        }
    }

    setAdresseerbaarObjectIdentificatie(adoId: string) {
        if(this.data instanceof VerhuisdIntergemeentelijkData) {
            this.data.verblijfplaats.adresseerbaarObjectIdentificatie = adoId;
        }
        else if(this.data instanceof VerhuisdIntergemeentelijkInternData) {
            this.data.c08.e1180 = adoId;
        }
    }

    setVerhuisdatum(datum: string) {
        const date = datum.replace(/-/g, '');

        if(this.data instanceof VerhuisdIntergemeentelijkData) {
            this.data.verblijfplaats.datumVan = toBrpApiDatum(date);
        }
        else if(this.data instanceof VerhuisdIntergemeentelijkInternData) {
            this.data.c08.e1030 = date;
        }
    }
}
