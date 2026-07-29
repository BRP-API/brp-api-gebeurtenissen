import {Given} from '@cucumber/cucumber';
import {AfnemerFactory} from './support/afnemer-factory';

Given(
  'de geauthenticeerde consumer {string} is een gemeente',
  async function (afnemerAanduiding) {
    await AfnemerFactory.create(this.context, afnemerAanduiding, true);
  },
);

Given(
  'de geauthenticeerde consumer {string} is geen gemeente',
  async function (afnemerAanduiding) {
    await AfnemerFactory.create(this.context, afnemerAanduiding, false);
  },
);
