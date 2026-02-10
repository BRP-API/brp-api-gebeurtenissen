import { Then } from '@cucumber/cucumber';
import { UnauthorizedProblemDetails, ConflictProblemDetails, NotFoundProblemDetails } from './support/problem-details';

Then('is de response {string}( met de volgende velden)', function (status: string) {
  const statuscode = status.split(' ')[0];
  switch (statuscode) {
    case '401':
      this.expected = new UnauthorizedProblemDetails();
      break;
    case '404':
      this.expected = new NotFoundProblemDetails();
      break;
    case '409':
      this.expected = new ConflictProblemDetails();
      break;
    default:
      this.expected = null;
      break;
  }
});

Then('{string} met tekst {string}', function (veld: string, waarde: string) {
  this.expected[veld] = waarde;
});
