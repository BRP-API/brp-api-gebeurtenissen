function naarMaandInTekst(maand: number): string {
    const maandenInTekst: { [key: number]: string } = {
        1: 'januari',
        2: 'februari',
        3: 'maart',
        4: 'april',
        5: 'mei',
        6: 'juni',
        7: 'juli',
        8: 'augustus',
        9: 'september',
        10: 'oktober',
        11: 'november',
        12: 'december'
    };

    return maandenInTekst[maand];
}

export abstract class BrpApiDatum {
    constructor(public type: string, public langFormaat: string) {}
}

export class VolledigeDatum extends BrpApiDatum {
    datum: string

    constructor(jaar: number, maand: number, dag: number) {
        super("Datum", `${dag} ${naarMaandInTekst(maand)} ${jaar}`);

        this.datum = `${jaar}-${String(maand).padStart(2, '0')}-${String(dag).padStart(2, '0')}`;
    }
}
