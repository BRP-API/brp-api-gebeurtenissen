import { Adres } from "../brp/adres-entity";
import { Persoon } from "../brp/persoon-entity";

export class SqlStatement {
    statementText: string;
    values: any[];

    constructor(statementText: string, values: any[] = []) {
        this.statementText = statementText;
        this.values = values;
    }
}

export function createLo3AdresInsertStatement(adres: Adres): SqlStatement {
    const insertPart = 'adres_id,gemeente_code,verblijf_plaats_ident_code';
    const valuesPart = '(SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),' +
                        '(SELECT COALESCE(MAX(gemeente_code), 0)+1 FROM public.lo3_adres),' +
                        '(SELECT LPAD((COALESCE(MAX(gemeente_code), 0)+1)::text, 4, \'0\') || \'000000000001\' FROM public.lo3_adres)';

    const statementText = `INSERT INTO public.lo3_adres(${insertPart}) VALUES(${valuesPart}) RETURNING *`;

    return new SqlStatement(statementText);
}

export function createLo3PlInsertStatement(persoon: Persoon): SqlStatement {
    const insertPart = 'pl_id,mutatie_dt,geheim_ind';
    const valuesPart = '(SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1';

    return new SqlStatement(`INSERT INTO public.lo3_pl(${insertPart}) VALUES(${valuesPart}) RETURNING *`,
                            [persoon.geheim_ind]);
}

export function createLo3PlPersoonInsertStatement(persoon: Persoon): SqlStatement {
    const insertPart = 'pl_id,persoon_type,stapel_nr,volg_nr,a_nr,burger_service_nr';
    const valuesPart = '$1,$2,$3,$4,' +
                        '(SELECT COALESCE(MAX(a_nr), 0)+1 FROM public.lo3_pl_persoon),' +
                        '(SELECT COALESCE(MAX(burger_service_nr), 0)+1 FROM public.lo3_pl_persoon)';

    return new SqlStatement(`INSERT INTO public.lo3_pl_persoon(${insertPart}) VALUES(${valuesPart}) RETURNING *`,
                             [persoon.pl_id, persoon.persoon_type, persoon.stapel_nr, persoon.volg_nr]);
}

export function createLo3PlVerblijfplaatsInsertStatement(persoon: Persoon): SqlStatement | null {
    if(persoon.verblijfplaats === undefined) {
        return null;
    }

    const verblijfplaats = persoon.verblijfplaats;

    const verblijfplaatsColumns = ['pl_id'].concat(verblijfplaats.getPropertyNames());
    const insertPart = verblijfplaatsColumns.join(',');
    const valuesPart = verblijfplaatsColumns.map((_, index) => `$${index + 1}`).join(',');

    return new SqlStatement(`INSERT INTO public.lo3_pl_verblijfplaats(${insertPart}) VALUES(${valuesPart})`,
                             [persoon.pl_id].concat(verblijfplaatsColumns.slice(1).map(col => (verblijfplaats as any)[col])));
}

export function createInsertStatements(persoon: Persoon): SqlStatement[] {
    const statements: SqlStatement[] = [];

    statements.push(createLo3PlInsertStatement(persoon));
    statements.push(createLo3PlPersoonInsertStatement(persoon));

    if(persoon.verblijfplaats) {
        statements.push(createLo3PlVerblijfplaatsInsertStatement(persoon)!);
    }

    return statements;
}

export function createSelectStatement(tableName: string, columns: string[], values: string[]): SqlStatement {
    const whereClause = columns.map((col, index) => `${col} = $${index + 1}`).join(' AND ');
    const statementText = `SELECT ${columns.join(', ')} FROM ${tableName} WHERE ${whereClause}`;
    return new SqlStatement(statementText, values);
}   