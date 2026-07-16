import chai from 'chai';

declare global {
  // eslint-disable-next-line @typescript-eslint/no-namespace
  export namespace Chai {
    interface Assertion {
      consecutiveNumbers(): Assertion;
    }
  }
}

export {};

export function registerCustomAssertions() {
  registerConsecutiveAssertion();
}

function registerConsecutiveAssertion() {
  chai.Assertion.addMethod('consecutiveNumbers', function () {
    const arr = this._obj;

    new chai.Assertion(arr).to.be.an('array');

    const valid = arr.every(
      (n: unknown, i: number) =>
        typeof n === 'number' &&
        Number.isFinite(n) &&
        (i === 0 || n === arr[i - 1] + 1),
    );

    this.assert(
      valid,
      'expected #{this} to contain consecutive numbers',
      'expected #{this} not to contain consecutive numbers',
    );
  });
}
