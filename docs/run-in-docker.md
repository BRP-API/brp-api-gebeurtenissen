# Run in Docker

De container images voor BRP API Gebeurtenissen zijn gepubliceerd in de Github Container Registry (`ghcr.io`).
Een aantal repositories zijn private. Om die container images te kunnen pullen moet je ingelogd zijn bij de registry host. Dit kan je doen door in te loggen met een Personal Access Token (PAT).

## Stappen om keten BRP API Gebeurtenissen in Docker te draaien

### (Optioneel) uitloggen bij registry host
```bash
docker logout ghcr.io
```

### Aanmaken PAT
Maak een classic token aan op https://github.com/settings/apps.
Ga naar Personal access tokens > Tokens (classic) > Generate new token > Generate new token (classic).
Selecteer de scope `write:packages`.

### Inloggen bij registry host
```bash
# zet een environment variable met je token en login
export TOKEN='<token>'
echo "$TOKEN" | docker login ghcr.io -u <gebruikersnaam> --password-stdin
```

> Op Windows PowerShell kun je in plaats daarvan gebruiken:
>
> ```powershell
> $env:TOKEN = '<token>'
> echo $env:TOKEN | docker login ghcr.io -u <gebruikersnaam> --password-stdin
> ```

### Container images pullen en starten
```bash
sh scripts/containers-start.sh
```

### Testpersoon toevoegen
```bash
sh scripts/add-testdata.sh
```

### Start gebeurtenissen
Start gebeurtenissen, wacht hiermee totdat Axon volledig is opgestart:
```bash
sh scripts/containers-gebeurtenissen-start.sh
```

###
Voer de HTTP requests in `../http/http-client.http` uit met het `dev` environment.


### Stop gebeurtenissen
```bash
sh scripts/containers-gebeurtenissen-stop.sh
```

### Stop containers db, axon en keycloak
```bash
sh scripts/containers-stop.sh
```
