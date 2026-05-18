import { Then } from '@cucumber/cucumber';
import { ProblemDetails} from './support/problem-details';
import { createObjectArrayFrom } from './support/dataTable2Object';

Then('is de response {string}( met de volgende velden)', function (status: string) {
    this.expected = ProblemDetails.create(status);
});

Then('{string} met tekst {string}', function (veld: string, waarde: string) {
    this.expected[veld] = waarde;
});

Then('heeft de response abonnees met de volgende velden', function (dataTable) {
    this.expected = {
        abonnees: createObjectArrayFrom(dataTable)
    };
});
