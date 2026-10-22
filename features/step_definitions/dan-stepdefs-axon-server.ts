import {Then} from '@cucumber/cucumber';
import {Afnemer} from './brp/afnemer-entity.js';
import {parseResponse} from './support/response-helpers.js';
import {expect} from 'chai';

Then(
  'is een {string} gebeurtenis gepubliceerd met abonneeNaam {string} voor afnemer {string}',
  async function (
    gebeurtenistype: string,
    abonneeNaam: string,
    naamAfnemer: string,
  ) {
    this.expected = null;
    const afnemer = this.context.afnemers[naamAfnemer] as Afnemer;

    const requestBody = [{labels: {afnemerId: afnemer.afnemerId}}];

    const response = await fetch(
      'http://localhost:8024/v2/dcbEvents/source?context=default&payloadContentType=application/json',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestBody),
      },
    );
    const responseBody = await parseResponse(response);

    const event = responseBody.body.events[0];
    expect(event.name).to.equal(
      `nl.rvig.brpapi.gebeurtenissen.${gebeurtenistype}`,
    );
    expect(event.payload.abonneeNaam).to.equal(abonneeNaam);
  },
);
