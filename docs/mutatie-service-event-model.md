BRP API Gebeurtenissen Mutatie Service Event Model

```mermaid
eventmodeling

tf 01 ui MutatieService
tf 02 cmd RegistreerAdres [[RegistreerAdres]]
tf 03 evt AdresGeregistreerd [[AdresGeregistreerd]]
tf 04 rmo lo3_adres ->> 03 [[lo3_adres]]

tf 05 rmo GeregistreerdeAdressen
tf 06 ui MutatieService

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
    gemeente_code: gemeentecode
    verblijf_plaats_ident_code: adresseerbaarObjectIdentificatie
    created_dt: createdAt
}
```
