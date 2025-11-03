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
      "g10": {
        "e1030": "20230101"
      },
      "g11": {
        "e1180": "0000123456789012"
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