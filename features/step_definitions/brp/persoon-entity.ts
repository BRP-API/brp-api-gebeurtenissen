import { Adres } from './adres-entity';
import { AdresBuitenland } from './adres-buitenland-entity';
import { Verblijfplaats, VerblijfplaatsBinnenland, VerblijfplaatsBuitenland } from './verblijfplaats-entity';
import { toBrpDate } from '../support/date-utils';

export class Persoon {
  pl_id?: string;
  persoon_type: string = 'P';
  stapel_nr: string = '0';
  volg_nr: string = '0';
  a_nr?: string;
  burger_service_nr?: string;
  geheim_ind: string = '0';
  geslachts_naam?: string;
  verblijfplaats?: Verblijfplaats;

  constructor(a_nr?: string, burger_service_nr?: string, geslachts_naam?: string) {
    if (a_nr) this.a_nr = a_nr;
    if (burger_service_nr) this.burger_service_nr = burger_service_nr;
    if (geslachts_naam) this.geslachts_naam = geslachts_naam;
  }

  getPropertyNames(): string[] {
    return ['pl_id', 'persoon_type', 'stapel_nr', 'volg_nr', 'a_nr', 'burger_service_nr', 'geheim_ind'];
  }

  verhuistNaarAdres(adres: Adres, datum: string): void {
    this.verblijfplaats = new VerblijfplaatsBinnenland(adres, toBrpDate(datum));
  }

  verhuistNaarAdresBuitenland(adres: AdresBuitenland, datum: string): void {
    this.verblijfplaats = new VerblijfplaatsBuitenland(adres, toBrpDate(datum));
  }
}
