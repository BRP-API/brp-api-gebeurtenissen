export class Aanduiding {
    type: 'persoon' | 'adres' | 'adresBuitenland' | 'command' | 'gepubliceerdGebeurtenis';
    id?: string;

    constructor(type: 'persoon' | 'adres' | 'adresBuitenland' | 'command' | 'gepubliceerdGebeurtenis', id?: string) {
        this.type = type;
        this.id = id;
    }

    get isPersoon(): boolean {
        return this.type === 'persoon';
    }

    get isAdres(): boolean {
        return this.type === 'adres';
    }

    get isAdresBuitenland(): boolean {
        return this.type === 'adresBuitenland';
    }

    get isCommand(): boolean {
        return this.type === 'command';
    }

    get isGepubliceerdGebeurtenis(): boolean {
        return this.type === 'gepubliceerdGebeurtenis';
    }

    static persoon(id: string): Aanduiding {
        return new Aanduiding('persoon', id);
    }

    static adres(id: string): Aanduiding {
        return new Aanduiding('adres', id);
    }

    static adresBuitenland(id: string): Aanduiding {
        return new Aanduiding('adresBuitenland', id);
    }

    static command(id: string): Aanduiding {
        return new Aanduiding('command', id);
    }

    static gepubliceerdGebeurtenis(): Aanduiding {
        return new Aanduiding('gepubliceerdGebeurtenis');
    }
}
