# Getting Started

### Aanmaken van een Personal access token in GitHub

- Navigeer naar GitHub en login
- Navigeer naar [Personal access tokens (classic)](https://github.com/settings/tokens)
- Klik op `Generate new token` dropdown button en selecteer `Generate new token (classic)` om de **New personal access token (classic)** scherm te openen.


In de **New personal access token (classic)** scherm
- geef de token een naam (bijv. Docker GHCR Access) in het *Note* veld
- selecteer *read:packages* scope. Deze staat onder de *write:packages scope

noteer de gegenereerde token

### Login met Docker op GitHub Container Registry (ghcr.io)

Voer de volgende statement uit:
```
docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
```

### Starten containers

Voer de volgende statement uit:
```
sh scripts/containers-start.sh
```

### Open Axon Server Dashboard

Navigeer in browser naar url `http://localhost:8024`

Open de **EVENT STORE Search** scherm en selecteer de **Live Updates** checkbox

### Publiceren van gebeurtenissen met behulp van de Gebeurtenissen Publiceren service

Gebruik hiervoor de **/personen/gebeurtenissen** endpoint.

voorbeeld van een `verhuisd.intergemeentelijk gebeurtenis publiceren` request

```
POST http://localhost:8080/personen/gebeurtenissen
Content-Type: application/json

{
  "type": "nl.brp.verhuisd.intergemeentelijk",
  "data": {
    "c01": {
      "g01": {
        "e0110": "1234567890"
      }
    },
    "c08": {
      "e1030": "20230101",
      "e1180": "0000123456789012"
    }
  }
}
```

voorbeeld van een `verhuisd.intergemeentelijk gebeurtenis met metadata publiceren` request

```
POST http://localhost:8080/personen/gebeurtenissen
Content-Type: application/json

{
  "type": "nl.brp.verhuisd.intergemeentelijk",
  "metadata": [
    { "naam": "test1", "waarde": "waarde1" },
    { "naam": "test2", "waarde": "waarde2" }
  ],
  "data": {
    "c01": {
      "g01": {
        "e0110": "1234567891"
      }
    },
    "c08": {
      "e1030": "00000000",
      "e1180": "0000123456789012"
    }
  }
}
```

### Bevragen van oudste ongelezen gebeurtenissen met behulp van Gebeurtenissen Bevragen service

Stuur hiervoor een GET request naar de **/personen/gebeurtenissen** endpoint

voorbeeld request

```
GET http://localhost:8082/personen/gebeurtenissen
```

voorbeeld response

```
{
  "type": "nl.brp.verhuisd.intergemeentelijk",
  "id": "f16c227e-fd85-41fd-9d0f-a90b9874e51e",
  "source": "brp",
  "specversion": "1.0.2",
  "data": {
    "burgerservicenummer": "1234567890",
    "verblijfplaats": {
      "adresseerbaarObjectIdentificatie": "0000123456789012",
      "datumVan": {
        "type": "JaarDatum",
        "langFormaat": "2024",
        "jaar": 2024
      }
    }
  }
}
```

### Stoppen containers

Voer de volgende statement uit:
```
sh scripts/containers-stop.sh
```