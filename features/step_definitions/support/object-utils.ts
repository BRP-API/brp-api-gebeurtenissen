/**
 * Utility function voor het zetten van een (geneste) property (aangegeven in puntnotatie) op een object
 * @param targetObject - Het object waarop de property moet worden gezet
 * @param path - pad (aangegeven in puntnotatie) van de geneste property (bijv. "user.profile.name")
 * @param value - waarde die moet worden toegekend aan de property
 * @throws {Error} wanneer het targetObject geen object is, de path geen string is, of wanneer de property niet kan worden gezet
 */
export function setNestedProperty(targetObject: any, path: string, value: any): void {
    if (!targetObject || typeof targetObject !== 'object') {
        throw new Error('Target object is geen object');
    }
    
    if (!path || typeof path !== 'string') {
        throw new Error('Path is geen string');
    }
    
    const keys = path.split('.').filter(key => key.length > 0);
    if (keys.length === 0) {
        throw new Error(`Ongeldig path: '${path}'`);
    }
    
    let current: any = targetObject;
    
    try {
        for (let i = 0; i < keys.length - 1; i++) {
            const key = keys[i];
            if (!(key in current)) {
                current[key] = {};
            }
            current = current[key];
        }
        current[keys[keys.length - 1]] = value;
    } catch (error: any) {
        throw new Error(`property '${path}' kan niet worden gezet: ${error.message}`);
    }
}