BRP API Gebeurtenissen Mutatie Service Event Model

```mermaid
eventmodeling

tf 01 ui MutatieService
tf 02 cmd RegistreerAdres [[RegistreerAdres]]
tf 03 evt AdresGeregistreerd [[AdresGeregistreerd]]
tf 04 rmo AdressenOverzicht
tf 05 ui MutatieService
tf 06 rmo lo3_adres ->> 03 [[lo3_adres]]

data RegistreerAdres {
    afnemerid: string (access token)
    gemeentecode: string
}

data AdresGeregistreerd {
    gemeentecode: string
    adresseerbaarObjectIdentificatie: string
    createdAt: timestamp
}

data lo3_adres {
    gemeente_code: smallint (gemeentecode)
    verblijf_plaats_ident_code: string (adresseerbaarObjectIdentificatie)
    created_dt: timestamp (createdAt)
}
```
