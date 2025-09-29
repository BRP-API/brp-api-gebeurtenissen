workspace "BRP API Gebeurtenissen" "Beheren van door BRPV gepubliceerde gebeurtenissen en afnemers notificeren over deze gebeurtenissen" {

    !identifiers hierarchical

    model {
        BRPV = softwareSystem "BRPV"
        BRPGN = softwareSystem "BRP API Gebeurtenissen" "Beheren van door BRPV gepubliceerde gebeurtenissen tbv BRP afnemers die personen willen volgen" {
            BRPGeb = group "Gebeurtenissen sub-systeem" {
                ES = container "Event Store" {
                    Description "opslag voor gebeurtenissen"
                    tags "Database"
                }
                EvtApi = container "Gebeurtenissen API" {
                    Description "Spring Boot & Kotlin\nBeheert gebeurtenissen in de Event Store"
                }
            }
            
            BRPSub = group "Abonnementen sub-systeem" {
                SubApi = container "Abonnementen API"
                SubDb = container "Abonnementen Database" {
                    tags "Database"
                }
            }
            
            BRPNot = group "Notificaties sub-systeem" {
                NP = container "Notificaties Publisher"
                MB = container "Message Broker"
            }
            
            MutApi = container "Mutatie API voor test/acceptatie doeleinden\nSimuleert de BRP(V)" {
                Description "Spring Boot & Kotlin"
            }
        }

        BRPV -> BRPGN.EvtApi "classificeert mutaties en publiceer deze als gebeurtenissen in"
        BRPGN.MutApi -> BRPGN.EvtApi "publiceert mutaties als gebeurtenissen in LAP/proefomgeving in"

        BRPGN.SubApi -> BRPGN.SubDb "leest en schrijft abonnementen in"

        BRPGN.EvtApi -> BRPGN.ES "beheert gebeurtenissen in"
        BRPGN.EvtApi -> BRPGN.SubApi "haalt abonnementen van afnemer op bij"

        BRPGN.NP -> BRPGN.MB "vertaalt gebeurtenis naar notificatie en publiceer in"
        BRPGN.NP -> BRPGN.EvtApi "bevraagt gebeurtenissen bij"
        BRPGN.NP -> BRPGN.SubApi "haalt abonnementen voor gebeurtenis op bij"

        BRPAfn = softwareSystem "BRP Afnemers"
        BRPBew = softwareSystem "BRP API Bewoningen" {
            Prj = container "Bewoningen Projector"
            Db = container "Bewoningen Database"
            Api = container "Bewoningen API"
        }

        BRPAfn -> BRPGN.SubApi "abonneert op gebeurtenis types met"
        BRPAfn -> BRPGN.MutApi "muteert persoon/adres in LAP/proefomgeving met"
        BRPAfn -> BRPGN.EvtApi "bevraagt gebeurtenissen bij"
        BRPAfn -> BRPGN.MB "haalt notificaties op bij"

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
            include BRPGN.EvtApi
            include BRPGN.SubApi
            include BRPGN.SubDb
            include BRPAfn
            include BRPV

            include BRPGN.NP
            include BRPGN.MB

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