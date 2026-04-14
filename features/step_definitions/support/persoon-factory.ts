import { Persoon } from "../brp/persoon-entity";
import { createPersoon } from "./repository";

export class PersoonFactory {
    static async create(context: any, aanduiding: string): Promise<Persoon> {
        if (!context.personen) {
            context.personen = {};
        }

        let persoon = context.personen[aanduiding];
        if(!persoon) {
            persoon = new Persoon(undefined, undefined, aanduiding);
            context.personen[aanduiding] = persoon;

            await createPersoon(persoon);
        }

        return persoon;
    }
}