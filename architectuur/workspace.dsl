workspace "BRP Gebeurtenissen en Notificaties" "Vertalen van data mutaties in de BRP naar gebeurtenissen en afnemers notificeren over deze gebeurtenissen" {

    !identifiers hierarchical

    model {
        BRP = softwareSystem "BRP"
        BRPGN = softwareSystem "BRP Gebeurtenissen en Notificaties" "Vertalen van data mutaties in de BRP naar gebeurtenissen en afnemers notificeren over deze gebeurtenissen" {
            ES = container "Event Store" {
                Description "Opslag van zowel interne als externe events"
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
            
            ConApi = container "BRP Berichten API consumer" {
                Description "Spring Boot & Kotlin"
            }
            
            BerEvtApi = container "Publiceert event op basis van BRP bericht"

            BewEvtApi = container "BRP API bewoning (event-driven)" {
                Description "Spring Boot & Kotlin"
            }
            PerEvtApi = container "BRP API personen"

        }
        BRPAfn = softwareSystem "BRP Afnemers"

        BRPAfn -> BRPGN.SubApi "abonneert op gebeurtenis types met"
        BRPGN.SubApi -> BRPGN.SubDb "leest en schrijft abonnementen in"
        BRPAfn -> BRPGN.MutApi "muteert persoon/adres in LAP/proefomgeving met"
        BRPGN.MutApi -> BRPGN.ES "publiceert (interne) gebeurtenissen in LAP/proefomgeving in"
        BRP -> BRPGN.ES "vertaalt mutaties naar (interne) gebeurtenissen en publiceer in"
        BRPGN.ES -> BRPGN.NP "consumeert (interne) gebeurtenissen bij"
        BRPGN.NP -> BRPGN.SubApi "haalt abonnementen voor gebeurtenis op bij"
        BRPGN.NP -> BRPGN.MB "vertaalt gebeurtenis naar notificatie en publiceer in"
        BRPAfn -> BRPGN.MB "haalt notificaties op bij"
        BRPAfn -> BRPGN.EvtApi "bevraagt gebeurtenis bij"
        BRPGN.EvtApi -> BRPGN.ES "haalt gebeurtenis op bij"

        BRP_B = softwareSystem "BRP Berichten API" "Uitwisselen van berichten tussen BRP-V en afnemers"
        BRPGN.ConApi -> BRP_B "pollt voor (nieuwe) berichten"
        BRPGN.ConApi -> BRPGN.ES "converteert bericht naar intern event"
       
        BRPGN.BewEvtApi -> BRPGN.ES "publiceert gebeurtenis \n (extern event)"
        BRPGN.ES -> BRPGN.BewEvtApi "luistert naar interne events"

        BRPGN.ConApi -> BRPGN.MutApi "Pollt mock BRP Bericht test-case"

        GN = softwareSystem "BRP Gebeurtenissen en notificaties naar afnemers" {
            gnApi = container "Gebeurtenissen API" {
                Description "Beheert gebeurtenissen"
            }

            bucket = container "Large file storage/bucket/database" { 
                Description "Gebeurtenissen inwoners per gemeente"
            }

            db = container "Gebeurtenissen data" {
                Tags "Database"
                Description "Geoptimaliseerd read-model voor gebeurtenissen"
            }

            HCdb = container "Haal-Centraal database (L.O.)" {
                Tags "Database"
            }

            ETL = container "ETL" {
                Description "Transformeer L.O. data naar optimaal read-model voor gebeurtenissen"
            }
        }

        BRPAfn -> GN.gnApi "bevraagt historische gebeurtenissen"

        BRPAfn -> GN.gnApi "bevraagt gebeurtenissen inwoners gemeente"

        BRPAfn -> GN.gnApi "pollt (rate-limited) gebeurtenis van bepaald type of persoon"

        GN.gnApi -> GN.bucket "slaat gebeurtenissen op"

        GN.gnApi -> GN.db "raadpleegt database"

        GN.HCdb -> GN.ETL "extract transform load"

        GN.ETL -> GN.db "slaat gebeurtenis op"


    }

    views {
        systemContext BRPGN "SystemContextDiagram" {
            include BRP
            include BRPGN
            include BRPAfn

            autolayout lr
        }

        container BRPGN "ContainerDiagram1" {
            include BRPGN.ES
            include BRPGN.NP
            include BRPGN.MB
            include BRPGN.MutApi
            include BRPGN.EvtApi
            include BRPGN.SubApi
            include BRPGN.SubDb
            include BRPAfn
            include BRP

            autolayout lr
        }

        container BRPGN "ContainerDiagram2" {
            include BRP_B
            include BRPAfn
            include BRPGN.MutApi
            include BRPGN.ConApi
            include BRPGN.EvtApi
            include BRPGN.ES
            include BRPGN.BewEvtApi
            include BRPGN.NP
            include BRPGN.SubApi
            include BRPGN.SubDb
            include BRPGN.MB

            autolayout lr
        }

        container BRPGN "ContainerDiagram3" {
            include GN.gnApi
            include BRPAfn
            include GN.db
            include GN.HCdb
            include GN.ETL
            include GN.bucket

            autolayout rl
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