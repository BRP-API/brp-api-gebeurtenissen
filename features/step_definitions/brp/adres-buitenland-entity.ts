export class AdresBuitenland {
  vertrek_land_adres_1?: string;
  vertrek_land_adres_2?: string;
  vertrek_land_adres_3?: string;
  vertrek_land_code?: string;

  constructor(regel1?: string, regel2?: string, regel3?: string, land_code?: string) {
    if (regel1) this.vertrek_land_adres_1 = regel1;
    if (regel2) this.vertrek_land_adres_2 = regel2;
    if (regel3) this.vertrek_land_adres_3 = regel3;
    if (land_code) this.vertrek_land_code = land_code;
  }
}
