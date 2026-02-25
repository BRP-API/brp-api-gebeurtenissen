import { Adres } from "../brp/adres-entity";
import { Afnemer } from "../brp/afnemer-entity";
import { Persoon } from "../brp/persoon-entity";

export class SqlStatement {
    statementText: string;
    values: any[];

    constructor(statementText: string, values: any[] = []) {
        this.statementText = statementText;
        this.values = values;
    }
}

function extendSqlStatementValuesPartForAdresId() {
    return '(SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres)';
}

function extendSqlStatementValuesPartForGemeentecode(adres: Adres, valuesPart: string, values: string[]) {
    if(valuesPart.length > 0) {
        valuesPart += ',';
    }
    if (adres.gemeente_code === undefined) {
        valuesPart += '(SELECT COALESCE(MAX(gemeente_code), 0)+1 FROM public.lo3_adres)';
    } else {
        valuesPart += `$${values.length + 1}`;
        values.push(adres.gemeente_code);
    }
    return valuesPart;
}

function extendSqlStatementValuesPartForVerblijfplaatsIdentificatieCode(adres: Adres, valuesPart: string, values: string[]) {
    if(valuesPart.length > 0) {
        valuesPart += ',';
    }
    if (adres.verblijf_plaats_ident_code === undefined) {
        valuesPart += '(SELECT LPAD((COALESCE(MAX(gemeente_code), 0)+1)::text, 4, \'0\') || \'000000000001\' FROM public.lo3_adres)';
    } else {
        valuesPart += `$${values.length + 1}`;
        values.push(adres.verblijf_plaats_ident_code);
    }
    return valuesPart;
}

export function createLo3AdresInsertStatement(adres: Adres): SqlStatement {
    let values: string[] = [];

    let valuesPart = extendSqlStatementValuesPartForAdresId();
    valuesPart = extendSqlStatementValuesPartForGemeentecode(adres, valuesPart, values);
    valuesPart = extendSqlStatementValuesPartForVerblijfplaatsIdentificatieCode(adres, valuesPart, values);

    const insertPart = 'adres_id,gemeente_code,verblijf_plaats_ident_code';
    const statementText = `INSERT INTO public.lo3_adres(${insertPart}) VALUES(${valuesPart}) RETURNING *`;

    return new SqlStatement(statementText, values);
}

export function createLo3AutorisatieInsertStatement(afnemer: Afnemer): SqlStatement {
    let insertPart = 'autorisatie_id,afnemer_code,geheimhouding_ind,verstrekkings_beperking,adres_vraag_bevoegdheid,ad_hoc_medium,tabel_regel_start_datum,afnemer_naam,ad_hoc_rubrieken';
    let valuesPart = '(SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie),' +
                        '(SELECT COALESCE(MAX(afnemer_code), 0)+1 FROM public.lo3_autorisatie),' +
                        '0,0,1,\'N\',20201128,$1,$2';

    const alleAdhocRubrieken =
        '10110 10120 10210 10220 10230 10240 10310 10320 10330 10410 16110 ' +
        '20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 ' +
        '30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 ' +
        '40510 46310 48510 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 51510 ' +
        '60810 60820 60830 76810 ' +
        '80910 80920 81010 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 81410 81420 88510 ' +
        '90120 90210 90220 90230 90240 90310 90320 90330 ' +
        '103910 103920 103930 113310 133110 133130 133810 133820 ' +
        'PAAD01 PAGL01 PAGZ01 PAHP01 PAKD01 PANM01 PANM02 PAOU01 PAVP05 PAVP06 AXBW01 PXVP07';

    let values = [ afnemer.aanduiding, alleAdhocRubrieken ];
    if(afnemer.gemeenteCode !== undefined) {
        insertPart += ',gemeente_code';
        valuesPart += `,$${values.length + 1}`;
        values.push(afnemer.gemeenteCode);
    }

    return new SqlStatement(`INSERT INTO public.lo3_autorisatie(${insertPart}) VALUES(${valuesPart}) RETURNING *`,
                            values);
}

export function createLo3PlInsertStatement(persoon: Persoon): SqlStatement {
    const insertPart = 'pl_id,mutatie_dt,geheim_ind';
    const valuesPart = '(SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1';

    return new SqlStatement(`INSERT INTO public.lo3_pl(${insertPart}) VALUES(${valuesPart}) RETURNING *`,
                            [persoon.geheim_ind]);
}

export function createLo3PlPersoonInsertStatement(persoon: Persoon): SqlStatement {
    const insertPart = 'pl_id,persoon_type,stapel_nr,volg_nr,geslachts_naam,a_nr,burger_service_nr';
    const valuesPart = '$1,$2,$3,$4,$5,' +
                        '(SELECT COALESCE(MAX(a_nr), 0)+1 FROM public.lo3_pl_persoon),' +
                        '(SELECT COALESCE(MAX(burger_service_nr), 0)+1 FROM public.lo3_pl_persoon)';

    return new SqlStatement(`INSERT INTO public.lo3_pl_persoon(${insertPart}) VALUES(${valuesPart}) RETURNING *`,
                             [persoon.pl_id, persoon.persoon_type, persoon.stapel_nr, persoon.volg_nr, persoon.geslachts_naam]);
}

export function createLo3PlVerblijfplaatsInsertStatement(persoon: Persoon): SqlStatement {
    if(persoon.verblijfplaats === undefined) {
        throw new Error('Er is geen verblijfplaats');
    }

    const verblijfplaats = persoon.verblijfplaats;

    const verblijfplaatsColumns = ['pl_id'].concat(verblijfplaats.getPropertyNames());
    const insertPart = verblijfplaatsColumns.join(',');
    const valuesPart = verblijfplaatsColumns.map((_, index) => `$${index + 1}`).join(',');

    return new SqlStatement(`INSERT INTO public.lo3_pl_verblijfplaats(${insertPart}) VALUES(${valuesPart})`,
                             [persoon.pl_id].concat(verblijfplaatsColumns.slice(1).map(col => (verblijfplaats as any)[col])));
}

export function createInsertStatements(persoon: Persoon): SqlStatement[] {
    const statements: SqlStatement[] = [
        createLo3PlInsertStatement(persoon),
        createLo3PlPersoonInsertStatement(persoon)
    ];

    if(persoon.verblijfplaats) {
        statements.push(createLo3PlVerblijfplaatsInsertStatement(persoon));
    }

    return statements;
}

export function createSelectStatement(tableName: string, columns: string[], values: string[]): SqlStatement {
    const whereClause = columns.map((col, index) => `${col} = $${index + 1}`).join(' AND ');
    const statementText = `SELECT ${columns.join(', ')} FROM ${tableName} WHERE ${whereClause}`;
    return new SqlStatement(statementText, values);
}

export function createLo3AdresDeleteStatement(adres: Adres): SqlStatement {
    const statementText = `DELETE FROM public.lo3_adres WHERE adres_id = $1`;
    return new SqlStatement(statementText, [adres.adres_id]);
}