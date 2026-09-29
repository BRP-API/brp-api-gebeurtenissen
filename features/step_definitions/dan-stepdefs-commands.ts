import {Then} from '@cucumber/cucumber';
import {getFirstEventMatching} from './support/axon-api-helpers.js';
import {expect} from 'chai';

const CLOUD_EVENT_PREFIX = 'nl.brp.';

Then(
  'is een {string} gebeurtenis gepubliceerd met het A-nummer van {string}',
  async function (gebeurtenisType: string, aanduidingPersoon: string) {
    const expectedANr: string = this.context.personen[aanduidingPersoon].a_nr;
    const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000);
    const event = await getFirstEventMatching(
      fiveMinutesAgo,
      gebeurtenisType,
      expectedANr,
    );
    expect(event.gebeurtenisCriteriaId.gebeurtenisType).to.equal(
      `${CLOUD_EVENT_PREFIX}${gebeurtenisType}`,
    );
    expect(event.gebeurtenisCriteriaId.anummer).to.equal(Number(expectedANr));
    this.axonEvent = event;
  },
);
