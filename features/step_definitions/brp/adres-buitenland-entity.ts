export class AdresBuitenland {
    regel1?: string;
    regel2?: string;
    regel3?: string;
    land_code?: string;

    constructor(regel1?: string,
                regel2?: string,
                regel3?: string,
                land_code?: string) {
        if(regel1) this.regel1 = regel1;
        if(regel2) this.regel2 = regel2;
        if(regel3) this.regel3 = regel3;
        if(land_code) this.land_code = land_code;
    }
}