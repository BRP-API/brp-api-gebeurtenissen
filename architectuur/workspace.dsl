workspace "BRP API Gebeurtenissen" "Beheren van door BRPV gepubliceerde gebeurtenissen en afnemers notificeren over deze gebeurtenissen" {

    !identifiers hierarchical

    model {
        BRPV = softwareSystem "BRPV"
        BRPGN = softwareSystem "BRP API Gebeurtenissen" "Beheren van door BRPV gepubliceerde gebeurtenissen tbv BRP afnemers die personen willen volgen" {
            ES = container "Event Store" {
                Description "opslag voor gebeurtenissen"
                tags "Database"
            }
            NP = container "Notificaties Publisher"
            MB = container "Message Broker"
            MutApi = container "Mutatie API voor test/acceptatie doeleinden\nSimuleert de BRP(V)" {
                Description "Spring Boot & Kotlin"
            }
            EvtApi = container "Gebeurtenissen API" {
                Description "Spring Boot & Kotlin\nBeheert gebeurtenissen in de Event Store"
            }
            SubApi = container "Abonnementen API"
            SubDb = container "Abonnementen Database" {
                tags "Database"
            }
        }
        BRPAfn = softwareSystem "BRP Afnemers"
        BRPBew = softwareSystem "BRP API Bewoningen" {
            Prj = container "Bewoningen Projector"
            Db = container "Bewoningen Database"
            Api = container "Bewoningen API"
        }

        BRPAfn -> BRPGN.SubApi "abonneert op gebeurtenis types met"
        BRPGN.SubApi -> BRPGN.SubDb "leest en schrijft abonnementen in"
        BRPAfn -> BRPGN.MutApi "muteert persoon/adres in LAP/proefomgeving met"
        BRPGN.MutApi -> BRPGN.EvtApi "publiceert mutaties als gebeurtenissen in LAP/proefomgeving in"
        BRPV -> BRPGN.EvtApi "classificeert mutaties en publiceer deze als gebeurtenissen in"
        BRPGN.EvtApi -> BRPGN.NP "bevraagt gebeurtenissen bij"
        BRPGN.NP -> BRPGN.SubApi "haalt abonnementen voor gebeurtenis op bij"
        BRPGN.NP -> BRPGN.MB "vertaalt gebeurtenis naar notificatie en publiceer in"
        BRPAfn -> BRPGN.MB "haalt notificaties op bij"
        BRPAfn -> BRPGN.EvtApi "bevraagt gebeurtenissen bij"
        BRPGN.EvtApi -> BRPGN.ES "beheert gebeurtenissen in"

        BRPBew.Prj -> BRPGN.EvtApi "bevraagt gebeurtenissen bij"
        BRPBew.Prj -> BRPBew.Db "beheert bewoningen in"
        BRPBew.Api -> BRPBew.Db "bevraagt bewoningen in"
        BRPAfn -> BRPBew.Api "bevraagt bewoningen met"
    }

    views {
        systemContext BRPGN "SystemContextDiagram" {
            include BRPV
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
            include BRPV

            include BRPBew.Prj
            include BRPBew.Db
            include BRPBew.Api

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