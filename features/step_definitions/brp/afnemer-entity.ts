export class Afnemer {
  // wordt ook gebuikt als client_id
  aanduiding: string;

  oin?: string;
  afnemerId?: string;
  gemeenteCode?: string;

  clientSecret?: string;

  idpId?: string;
  idpScopeId?: string;

  clientSetup: boolean = false;

  setupCompleted() {
    this.clientSetup = true;
  }

  constructor(aanduiding: string) {
    this.aanduiding = aanduiding;
  }
}
