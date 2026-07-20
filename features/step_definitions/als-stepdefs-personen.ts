import {When} from '@cucumber/cucumber';
import {
  raadpleegMetBurgerservicenummer,
  raadpleegVerblijfplaatshistorieMetPeriode,
} from './support/personen-api-helpers';
import {AfnemerFactory} from './support/afnemer-factory';

When(
  '{string} wordt gevraagd van {string}',
  async function (fieldsList: string, persoonAanduiding: string) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Hengelo',
    );

    const persoon = this.context.personen[persoonAanduiding];

    fieldsList = fieldsList.replaceAll(' en ', ','); // kommagescheiden velden
    fieldsList = fieldsList.replaceAll(' ', ''); // spaties tussen velden verwijderen
    const fields = fieldsList.split(',');

    const response = await raadpleegMetBurgerservicenummer(
      afnemer,
      persoon,
      fields,
    );

    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);

When(
  'verblijfplaatshistorie wordt gevraagd van {string} over de periode {string} tot {string}',
  async function (
    persoonAanduiding: string,
    datumVan: string,
    datumTot: string,
  ) {
    const afnemer = await AfnemerFactory.create(
      this.context,
      'Gemeente Hengelo',
    );

    const persoon = this.context.personen[persoonAanduiding];

    const response = await raadpleegVerblijfplaatshistorieMetPeriode(
      afnemer,
      persoon,
      datumVan,
      datumTot,
    );

    this.result = response.body;
    this.responseStatusCode = response.statusCode;
  },
);
