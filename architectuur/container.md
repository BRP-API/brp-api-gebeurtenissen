```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Container View: BRP API Gebeurtenissen"]
    style diagram fill:#ffffff,stroke:#ffffff

    1("<div style='font-weight: bold'>BRPV</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 1 fill:#ffffff,stroke:#0773af,color:#0773af
    14("<div style='font-weight: bold'>BRP Afnemers</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 14 fill:#ffffff,stroke:#0773af,color:#0773af

    subgraph 2 ["BRP API Gebeurtenissen"]
      style 2 fill:#ffffff,stroke:#0773af,color:#0773af

      3[("<div style='font-weight: bold'>Event Store</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div><div style='font-size: 80%; margin-top:10px'>opslag voor gebeurtenissen<br />Axon Server</div>")]
      style 3 fill:#ffffff,stroke:#0773af,color:#0773af
      4("<div style='font-weight: bold'>Gebeurtenissen Publiceren API</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div><div style='font-size: 80%; margin-top:10px'>Spring Boot & Kotlin Beheert<br />gebeurtenissen in de Event<br />Store</div>")
      style 4 fill:#ffffff,stroke:#0773af,color:#0773af
      5("<div style='font-weight: bold'>Gebeurtenissen Bevragen API</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div><div style='font-size: 80%; margin-top:10px'>Spring Boot & Kotlin Levert<br />gebeurtenissen opgeslagen in<br />de Event Store</div>")
      style 5 fill:#ffffff,stroke:#0773af,color:#0773af
      6("<div style='font-weight: bold'>Abonnementen API</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 6 fill:#ffffff,stroke:#0773af,color:#0773af
      7("<div style='font-weight: bold'>Mutatie API voor test/acceptatie doeleinden\nSimuleert de BRP(V)</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div><div style='font-size: 80%; margin-top:10px'>Spring Boot & Kotlin</div>")
      style 7 fill:#ffffff,stroke:#0773af,color:#0773af
    end

    7-. "<div>publiceert mutaties als<br />gebeurtenissen in<br />LAP/proefomgeving in</div><div style='font-size: 70%'></div>" .->4
    6-. "<div>publiceert abonnement<br />gebeurtenissen in</div><div style='font-size: 70%'></div>" .->3
    4-. "<div>publiceert gebeurtenissen in</div><div style='font-size: 70%'></div>" .->3
    5-. "<div>abonneert op abonnement<br />gebeurtenissen in</div><div style='font-size: 70%'></div>" .->3
    14-. "<div>beheert BRP gebeurtenis<br />abonnementen met</div><div style='font-size: 70%'></div>" .->6
    14-. "<div>muteert persoon/adres in<br />LAP/proefomgeving met</div><div style='font-size: 70%'></div>" .->7
    14-. "<div>bevraagt gebeurtenissen bij</div><div style='font-size: 70%'></div>" .->5
    1-. "<div>classificeert mutaties en<br />publiceer deze als<br />gebeurtenissen in</div><div style='font-size: 70%'></div>" .->4

  end
  ```
  