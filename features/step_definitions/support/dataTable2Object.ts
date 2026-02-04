import { DataTable } from '@cucumber/cucumber';
import { toDateOrString } from './date-utils';

function setPropertyValue(obj: any, propertyName: string, propertyValue: string, dateAsDate: boolean) {
    obj[propertyName] = toDateOrString(propertyValue, dateAsDate);
}

function setNestedPropertyValue(obj: any, propertyName: string, propertyValue: string, dateAsDate: boolean) {
    const propertyNames = propertyName.split('.');

    if(propertyNames.length == 1) {
        setPropertyValue(obj, propertyName, propertyValue, dateAsDate);
    }
    else {
        const propName = propertyNames[0];
        if(obj[propName] === undefined) {
            obj[propName] = {};
        }
        setNestedPropertyValue(obj[propName], propertyNames.splice(1).join('.'), propertyValue, dateAsDate);
    }
}

function setProperty(obj: any, propertyName: string, propertyValue: string, dateAsDate: boolean) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        setNestedPropertyValue(obj, propertyName, propertyValue, dateAsDate);
    }
    else {
        setPropertyValue(obj, propertyName, propertyValue, dateAsDate);
    }
}

function mapRowToProperty(obj: any, row: Record<string, string>, dateAsDate: boolean) {
    setProperty(obj, row.naam, row.waarde, dateAsDate);
}

function setObjectPropertiesFrom(obj: any, dataTable: DataTable, dateAsDate: boolean) {
    if(dataTable.raw()[0][0] === 'naam') {
        for (const row of dataTable.hashes()) {
            mapRowToProperty(obj, row, dateAsDate);
        }
    }
    else {
        const row = dataTable.hashes()[0];
        for (const propertyName of Object.keys(row)) {
            setProperty(obj, propertyName, row[propertyName], dateAsDate);
        }
    }
}

export function createObjectFrom(dataTable: DataTable, dateAsDate: boolean = false): any {
    const obj: any = {};

    setObjectPropertiesFrom(obj, dataTable, dateAsDate);

    return obj;
}
