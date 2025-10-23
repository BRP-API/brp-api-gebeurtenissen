import { Then } from '@cucumber/cucumber';
import { CloudEvent } from './support/cloud-events';
import { setNestedProperty } from './support/object-utils';
import { Aanduiding } from './support/aanduiding';
import { toBrpApiDatum } from './support/date-utils';

Then('zijn er geen gebeurtenissen gepubliceerd', function () {
});

Then('is een {string} gebeurtenis gepubliceerd( met de volgende velden)( met de volgende data)', function (gebeurtenisType: string) {
    this.expected = new CloudEvent(`nl.brp.${gebeurtenisType}`);
    this.aanduiding = Aanduiding.gepubliceerdGebeurtenis();
});

Then('is een {string} gebeurtenis geleverd( met de volgende velden)( met de volgende data)', function (gebeurtenisType: string) {
    this.expected = new CloudEvent(`nl.brp.${gebeurtenisType}`);
});

Then('{string} met de afnemer id van {string}', function (veld: string, aanduidingAfnemer: string) {
    setNestedProperty(this.expected, `data.${veld}`, aanduidingAfnemer);
});

Then('het A-nummer van {string}', function (aanduidingPersoon: string) {
    setNestedProperty(this.expected, 'data.c01.g01.e0110', this.context.personen[aanduidingPersoon].a_nr);
});

Then('de vanaf datum van de opgave van verhuizing van {string}', function (persoonAanduiding: string) {
    const datum = this.command.verhuisdatum.replace(/-/g, '');
    if(this.aanduiding?.isGepubliceerdGebeurtenis) {
        setNestedProperty(this.expected, 'data.c08.g10.e1030', datum);
    } else {
        setNestedProperty(this.expected, 'data.datumVan', toBrpApiDatum(datum));
    }
});

Then('de adresseerbaar object identificatie van het adres {string}', function (adresAanduiding: string) {
    if(this.aanduiding?.isGepubliceerdGebeurtenis) {
        setNestedProperty(this.expected, 'data.c08.g11.e1180', this.context.adressen[adresAanduiding].verblijf_plaats_ident_code);
    } else {
        setNestedProperty(this.expected, 'data.adresseerbaarObjectIdentificatie', this.context.adressen[adresAanduiding].verblijf_plaats_ident_code);
    }
});

Then('het burgerservicenummer van {string}', function (aanduidingPersoon: string) {
    setNestedProperty(this.expected, 'data.burgerservicenummer', this.context.personen[aanduidingPersoon].burger_service_nr);
});
