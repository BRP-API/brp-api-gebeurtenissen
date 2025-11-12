import { Then } from '@cucumber/cucumber';
import { CloudEvent } from './support/cloud-events';
import { setNestedProperty } from './support/object-utils';

Then('zijn er geen gebeurtenissen gepubliceerd', function () {
});

Then('is een {string} gebeurtenis gepubliceerd( met de volgende velden)', function (gebeurtenisType: string) {
    this.expected = new CloudEvent(gebeurtenisType);
});

Then('{string} met de afnemer id van {string}', function (veld: string, aanduidingAfnemer: string) {
    setNestedProperty(this.expected, `data.${veld}`, aanduidingAfnemer);
});
