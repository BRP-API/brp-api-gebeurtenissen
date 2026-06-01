import {defineParameterType, Then} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';
import {createObjectArrayFrom} from './support/dataTable2Object';
import {expect} from "chai";

Then('is de response {string}( met de volgende velden)', function (status: string) {
    this.expected = ProblemDetails.create(status);
    expect(this.responseStatusCode).to.equal(ProblemDetails.getStatusCode(status))
    expect(this.result.status).to.equal(this.expected.status)
    expect(this.result.type).to.equal(this.expected.type)
});

Then('is de success response {string}( met de volgende velden)', function (status: string) {
    this.expected = null;
    expect(this.responseStatusCode).to.equal(ProblemDetails.getStatusCode(status))
});

Then('{string} met tekst {string}', function (veld: string, waarde: string) {
    this.expected[veld] = waarde;
    expect(this.result[veld]).to.equal(this.expected[veld])
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
