import { Then, defineParameterType } from '@cucumber/cucumber';
import { ProblemDetails} from './support/problem-details';
import { createObjectArrayFrom } from './support/dataTable2Object';

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
    this.expected = {
        [objectNaam]: createObjectArrayFrom(dataTable)
    };
});