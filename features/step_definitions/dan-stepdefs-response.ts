import { Then, defineParameterType } from '@cucumber/cucumber';
import { ProblemDetails} from './support/problem-details';
import { createObjectArrayWithPersoonAanduidingenFrom } from './support/dataTable2Object';
import { Persoon } from './brp/persoon-entity';

Then('is de response {string}( met de volgende velden)', function (status: string) {
    this.expected = ProblemDetails.create(status);
});

Then('{string} met tekst {string}', function (veld: string, waarde: string) {
    this.expected[veld] = waarde;
});

defineParameterType({
    name: 'objectNaam',
    regexp: /(abonnees|groepen|gebeurtenistypes|abonnementen|gebeurtenissen)/
});

Then('worden volgende {objectNaam} geleverd', function (objectNaam: string, dataTable) {
    const personen: Record<string, Persoon> = this.context.personen || {};

    this.expected = {
        [objectNaam]: createObjectArrayWithPersoonAanduidingenFrom(dataTable, personen)
    };
});