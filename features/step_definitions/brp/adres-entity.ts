export class Adres {
  adres_id?: number;
  gemeente_code?: string;
  verblijf_plaats_ident_code?: string;
  postcode: string;
  huis_nr: bigint;

  constructor(gemeente_code?: string, verblijf_plaats_ident_code?: string) {
    if (gemeente_code) this.gemeente_code = gemeente_code;
    if (verblijf_plaats_ident_code)
      this.verblijf_plaats_ident_code = verblijf_plaats_ident_code;

    this.postcode = this.randomPostcode();
    this.huis_nr = this.randomHuisnummer();
  }

  getPropertyNames(): string[] {
    return ['adres_id', 'gemeente_code', 'verblijf_plaats_ident_code', 'postcode', 'huis_nr'];
  }

  randomPostcode(): string {
    const cijfers: string = String(Math.floor(Math.random() * 9999)).padStart(
      4,
      '0',
    );
    const letterRange = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const letter1 = letterRange.charAt(Math.floor(Math.random() * 26));
    const letter2 = letterRange.charAt(Math.floor(Math.random() * 26));

    return cijfers + letter1 + letter2;
  }

  randomHuisnummer(): bigint {
    return BigInt(Math.floor(Math.random() * 9999));
  }
}
