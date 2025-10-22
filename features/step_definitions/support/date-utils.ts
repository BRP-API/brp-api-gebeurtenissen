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
