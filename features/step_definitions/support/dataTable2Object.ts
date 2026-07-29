import {DataTable} from '@cucumber/cucumber';
import {toDateOrString} from './date-utils.js';
import {Persoon} from '../brp/persoon-entity';

function setPropertyValue(
  obj: any,
  propertyName: string,
  propertyValue: string,
  dateAsDate: boolean,
) {
  if (propertyName === 'huisnummer') {
    obj[propertyName] = parseInt(propertyValue);
  } else {
    obj[propertyName] = toDateOrString(propertyValue, dateAsDate);
  }
}

function setNestedPropertyValue(
  obj: any,
  propertyName: string,
  propertyValue: string,
  dateAsDate: boolean,
) {
  const propertyNames = propertyName.split('.');

  if (propertyNames.length === 1) {
    setPropertyValue(obj, propertyName, propertyValue, dateAsDate);
  } else {
    const propName = propertyNames[0];
    if (obj[propName] === undefined) {
      obj[propName] = {};
    }
    setNestedPropertyValue(
      obj[propName],
      propertyNames.splice(1).join('.'),
      propertyValue,
      dateAsDate,
    );
  }
}

function setProperty(
  obj: any,
  propertyName: string,
  propertyValue: string,
  dateAsDate: boolean,
) {
  if (propertyValue === undefined || propertyValue === '') {
    return;
  }
  const cleanedPropertyName = propertyName
    .replace(/\s*\(.*?\)\s*/g, ' ')
    .trim();
  if (propertyName.includes('.')) {
    setNestedPropertyValue(obj, cleanedPropertyName, propertyValue, dateAsDate);
  } else {
    setPropertyValue(obj, cleanedPropertyName, propertyValue, dateAsDate);
  }
}

function mapRowToProperty(
  obj: any,
  row: Record<string, string>,
  dateAsDate: boolean,
) {
  setProperty(obj, row.naam, row.waarde, dateAsDate);
}

function setObjectPropertiesFrom(
  obj: any,
  dataTable: DataTable,
  dateAsDate: boolean,
) {
  if (dataTable.raw()[0][0] === 'naam') {
    for (const row of dataTable.hashes()) {
      mapRowToProperty(obj, row, dateAsDate);
    }
  } else {
    const row = dataTable.hashes()[0];
    for (const propertyName of Object.keys(row)) {
      setProperty(obj, propertyName, row[propertyName], dateAsDate);
    }
  }
}

export function createObjectFrom(
  dataTable: DataTable,
  dateAsDate: boolean = false,
): any {
  const obj: any = {};

  setObjectPropertiesFrom(obj, dataTable, dateAsDate);

  return obj;
}

export function createObjectArrayFrom(
  dataTable: DataTable,
  dateAsDate: boolean = false,
): any[] {
  const retval = [];

  for (const row of dataTable.hashes()) {
    const obj = {};

    for (const propertyName of Object.keys(row)) {
      setProperty(obj, propertyName, row[propertyName], dateAsDate);
    }

    retval.push(obj);
  }

  return retval;
}

export function convertNumericStrings(obj: any) {
  const result: any = {};

  for (const [key, value] of Object.entries(obj)) {
    if (
      typeof value === 'string' &&
      value.trim() !== '' &&
      !isNaN(Number(value))
    ) {
      result[key] = Number(value);
    } else {
      result[key] = value;
    }
  }

  return result;
}

// Zet een datatable om naar een array van objecten, waarbij het 'burgerservicenummer' veld wordt vervangen door het daadwerkelijke burgerservicenummer van de persoon in de context
// Het burgerservicenummer veld moet de aanduiding bevatten naar een persoon in de context
export function createObjectArrayWithPersoonAanduidingenFrom(
  dataTable: DataTable,
  personen: Record<string, Persoon>,
  dateAsDate: boolean = false,
): any[] {
  return createObjectArrayFrom(dataTable, dateAsDate).map(obj => {
    for (const key in obj) {
      if (key === 'burgerservicenummer') {
        const persoon = personen[obj[key]];
        if (persoon) {
          obj[key] = persoon.burger_service_nr;
        }
      }
    }
    return obj;
  });
}

export function createArrayFrom(dataTable: DataTable): any[] {
  const retval: string[] = [];

  for (const row of dataTable.hashes()) {
    for (const propertyName of Object.keys(row)) {
      retval.push(row[propertyName]);
    }
  }

  return retval;
}
