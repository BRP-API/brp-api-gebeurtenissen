workspace "Name" "Description"

    !identifiers hierarchical

    model {
        BRP = softwareSystem "BRP"
        BRPGN = softwareSystem "BRP Gebeurtenissen en Notificaties" {
            CDC = container "Change Data Capture Tool"
            ES = container "Event Store" {
                tags "Database"
            }
            NP = container "Notificaties Publisher"
            MB = container "Message Broker"
            MutApi = container "Mutatie API voor test/acceptatie doeleinden" {
                Description "Spring Boot & Kotlin"
            }
            EvtApi = container "Gebeurtenissen API" {
                Description "Spring Boot & Kotlin\nFilter velden op basis van autorisatie en protocolleer"
            }
            SubApi = container "Abonnementen API"
            SubDb = container "Abonnementen Database" {
                tags "Database"
            }
        }
        BRPAfn = softwareSystem "BRP Afnemers"

        BRPAfn -> BRPGN.SubApi "abonneert op gebeurtenissen met"
        BRPGN.SubApi -> BRPGN.SubDb "leest en schrijft abonnementen in"
        BRPGN.MutApi -> BRP "muteert gegevens van personen"
        BRP -> BRPGN.CDC "afvangen van persoon mutaties"
        BRPGN.CDC -> BRPGN.ES "vertaalt mutaties naar gebeurtenissen en publiceer in"
        BRPGN.ES -> BRPGN.NP "haalt gebeurtenissen op bij"
        BRPGN.NP -> BRPGN.SubApi "haalt abonnementen voor gebeurtenis op bij"
        BRPGN.NP -> BRPGN.MB "vertaalt gebeurtenis naar notificatie en publiceer in"
        BRPAfn -> BRPGN.MB "haalt notificaties op bij"
        BRPAfn -> BRPGN.EvtApi "bevraagt gebeurtenis bij"
        BRPGN.EvtApi -> BRPGN.ES "haalt gebeurtenis op bij"
    }

    views {
        systemContext BRPGN "SystemContextDiagram" {
            include *
            autolayout lr
        }

        container BRPGN "ContainerDiagram" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #0773af
                stroke #0773af
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "Boundary" {
                strokeWidth 5
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    }

}