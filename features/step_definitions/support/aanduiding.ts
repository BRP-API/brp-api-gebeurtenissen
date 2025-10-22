export class Aanduiding {
    type: 'persoon' | 'adres' | 'command';
    id: string;

    constructor(type: 'persoon' | 'adres' | 'command', id: string) {
        this.type = type;
        this.id = id;
    }

    get isPersoon(): boolean {
        return this.type === 'persoon';
    }

    get isAdres(): boolean {
        return this.type === 'adres';
    }

    get isCommand(): boolean {
        return this.type === 'command';
    }
    
    static persoon(id: string): Aanduiding {
        return new Aanduiding('persoon', id);
    }

    static adres(id: string): Aanduiding {
        return new Aanduiding('adres', id);
    }

    static command(id: string): Aanduiding {
        return new Aanduiding('command', id);
    }
}
