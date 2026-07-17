import {When} from '@cucumber/cucumber';
import {
  raadpleegMetBurgerservicenummer,
} from './support/personen-api-helpers';
import {AfnemerFactory} from './support/afnemer-factory';
import {PersoonFactory} from './support/persoon-factory';

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

    this.result = await raadpleegMetBurgerservicenummer(
      afnemer,
      persoon,
      fields,
    );
  },
);
