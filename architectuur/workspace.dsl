workspace "BRP API Gebeurtenissen" "Beheren van door BRPV gepubliceerde gebeurtenissen en afnemers notificeren over deze gebeurtenissen" {

    !identifiers hierarchical

    model {
        BRPV = softwareSystem "BRPV"
        BRPGN = softwareSystem "BRP API Gebeurtenissen" "Beheren van door BRPV gepubliceerde gebeurtenissen tbv BRP afnemers die personen willen volgen" {
            ES = container "Event Store" {
                Description "opslag voor gebeurtenissen\nAxon Server"
                tags "Database"
            }
            EvtPubApi = container "Gebeurtenissen Publiceren API" {
                Description "Spring Boot & Kotlin\nBeheert gebeurtenissen in de Event Store"
            }
            EvtApi = container "Gebeurtenissen Bevragen API" {
                Description "Spring Boot & Kotlin\nLevert gebeurtenissen opgeslagen in de Event Store"
            }
            SubApi = container "Abonnementen API"

            MutApi = container "Mutatie API voor test/acceptatie doeleinden\nSimuleert de BRP(V)" {
                Description "Spring Boot & Kotlin"
            }
        }

        BRPV -> BRPGN.EvtPubApi "classificeert mutaties en publiceer deze als gebeurtenissen in"
        BRPGN.MutApi -> BRPGN.EvtPubApi "publiceert mutaties als gebeurtenissen in LAP/proefomgeving in"

        BRPGN.SubApi -> BRPGN.ES "publiceert abonnement gebeurtenissen in"

        BRPGN.EvtPubApi -> BRPGN.ES "publiceert gebeurtenissen in"
        BRPGN.EvtApi -> BRPGN.ES "abonneert op abonnement gebeurtenissen in"

        BRPAfn = softwareSystem "BRP Afnemers"
        BRPBew = softwareSystem "BRP API Bewoningen" {
            Prj = container "Bewoningen Projector"
            Db = container "Bewoningen Database" {
                tags "Database"
            }
            Api = container "Bewoningen API"
        }

        BRPAfn -> BRPGN.SubApi "beheert BRP gebeurtenis abonnementen met"
        BRPAfn -> BRPGN.MutApi "muteert persoon/adres in LAP/proefomgeving met"
        BRPAfn -> BRPGN.EvtApi "bevraagt gebeurtenissen bij"

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
            include BRPGN.MutApi
            include BRPGN.EvtPubApi
            include BRPGN.EvtApi
            include BRPGN.SubApi
            include BRPAfn
            include BRPV

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