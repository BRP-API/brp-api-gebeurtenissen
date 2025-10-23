/**
 * Converteer een datum string in dd-mm-yyyy formaat naar yyyymmdd formaat
 * @param dateString - Datum in dd-mm-yyyy formaat (bijv., "14-04-2020")
 * @returns Datum in yyyymmdd formaat (bijv., "20200414")
 * @throws Error als de input ongeldig is
 */
export function toBrpDate(dateString: string): string {
    if (!dateString || typeof dateString !== 'string') {
        throw new Error('ongeldig datum string');
    }

    const dateRegex = /^(\d{1,2})-(\d{1,2})-(\d{4})$/;
    const match = dateString.match(dateRegex);
    
    if (!match) {
        throw new Error('ongeldig datum string');
    }

    const [, day, month, year] = match;
    
    // Voeg voorloopnullen toe aan dag en maand
    const paddedDay = day.padStart(2, '0');
    const paddedMonth = month.padStart(2, '0');

    return `${year}${paddedMonth}${paddedDay}`;
}

/**
 * Converteer een datum string in dd-mm-yyyy formaat naar yyyy-mm-dd formaat
 * @param dateString - Datum in dd-mm-yyyy formaat (bijv., "14-04-2020")
 * @returns Datum in yyyy-mm-dd formaat (bijv., "2020-04-14")
 * @throws Error als de input ongeldig is
 */
export function toIsoDate(dateString: string): string {
    if (!dateString || typeof dateString !== 'string') {
        throw new Error('ongeldig datum string');
    }

    const dateRegex = /^(\d{1,2})-(\d{1,2})-(\d{4})$/;
    const match = dateString.match(dateRegex);
    
    if (!match) {
        throw new Error('ongeldig datum string');
    }

    const [, day, month, year] = match;
    
    // Voeg voorloopnullen toe aan dag en maand
    const paddedDay = day.padStart(2, '0');
    const paddedMonth = month.padStart(2, '0');

    return `${year}-${paddedMonth}-${paddedDay}`;
}

function isVolledigeDatum(jaar: string, maand: string, dag: string): boolean {
    return maand !== '00' && dag !== '00';
}

function naarMaandInTekst(maand: string): string {
    const maandenInTekst: { [key: string]: string } = {
        '01': 'januari',
        '02': 'februari',
        '03': 'maart',
        '04': 'april',
        '05': 'mei',
        '06': 'juni',
        '07': 'juli',
        '08': 'augustus',
        '09': 'september',
        '10': 'oktober',
        '11': 'november',
        '12': 'december'
    };

    return maandenInTekst[maand];
}

/**
 * Converteer een datum in yyyymmdd formaat naar een BRP API datum (polymorf)
 * @param dateString - Datum in ddmmyyyy formaat
 * @returns BRP API datum
 */
export function toBrpApiDatum(dateString: string): any | undefined {
    const dateRegex = /^(\d{4})(\d{2})(\d{2})$/;
    const match = dateString.match(dateRegex);
    
    if (!match) {
        throw new Error('ongeldig datum string');
    }

    const [, year, month, day] = match;

    if (isVolledigeDatum(year, month, day)) {
        return {
            type: 'Datum',
            datum: `${year}-${month}-${day}`,
            langFormaat: `${parseInt(day)} ${naarMaandInTekst(month)} ${year}`
        };
    }

    return undefined;
}