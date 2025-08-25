```mermaid
sequenceDiagram
    participant Afnemer
    box Grey BRP Gebeurtenissen<br/>(alleen in test/LAP)
    participant MA as Mutatie API<br/>(tbv test doeleinden)
    end
    participant Gemeente
    participant BRPV
    box Grey BRP Gebeurtenissen
    participant ES as EventStore
    participant NP as Notificaties Publisher
    participant SubApi as Abonnementen API
    participant MB as Message Broker
    participant EvtApi as Gebeurtenissen API
    end

    Afnemer->>SubApi: abonneert op gebeurtenis types
    Afnemer->>MA: muteert persoon of adres<br/>in LAP/proefomgeving
    MA->>ES: publiceert (interne) gebeurtenis<br/>in LAP/proefomgeving
    Gemeente->>BRPV: muteert persoon of adres
    BRPV->>ES: publiceert (interne) gebeurtenis
    NP->>ES: consumeert (interne) gebeurtenis
    NP->>NP: vertaalt (interne) gebeurtenis naar externe gebeurtenis
    NP->>ES: publiceert (externe) gebeurtenis
    NP->>SubApi: haalt abonnementen voor gebeurtenis op
    NP->>NP: vertaalt gebeurtenis naar notificatie
    NP->>MB: publiceert notificatie(s)
    Afnemer->>MB: haalt notificaties op
    Afnemer->>EvtApi: bevraagt gebeurtenissen
    EvtApi->>ES: haalt gevraagde gebeurtenissen op
    EvtApi->>EvtApi: filtert velden op basis van autorisatie en protocolleer
    EvtApi->>Afnemer: levert gevraagde gebeurtenissen
```
