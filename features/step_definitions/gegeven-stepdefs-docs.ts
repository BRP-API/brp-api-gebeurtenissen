import {Given} from '@cucumber/cucumber';
import {ProblemDetails} from './support/problem-details';

Given('heeft id {string}', function (id: string) {
  if (this.huidigAanduiding?.isAdres) {
    this.context.adressen[this.huidigAanduiding.id].adres_id = id;
  }
  if (this.huidigAanduiding?.isPersoon) {
    this.context.personen[this.huidigAanduiding.id].pl_id = id;
  }
});

Given('de gepubliceerde gebeurtenis', function (docString: string) {
  this.result = JSON.parse(docString);
});

Given('de geleverde gebeurtenis', function (docString: string) {
  this.result = JSON.parse(docString);
});

Given('de response met {string}', function (status: string, docString: string) {
  this.responseStatusCode = ProblemDetails.getStatusCode(status);
  this.result = JSON.parse(docString);
});
