```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["BRP Gebeurtenissen en Notificaties - System Context"]
    style diagram fill:#ffffff,stroke:#ffffff

    1("<div style='font-weight: bold'>BRP</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 1 fill:#dddddd,stroke:#0773af,color:#0773af
    11("<div style='font-weight: bold'>BRP Afnemers</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 11 fill:#dddddd,stroke:#0773af,color:#0773af
    2("<div style='font-weight: bold'>BRP Gebeurtenissen en Notificaties</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 2 fill:#dddddd,stroke:#0773af,color:#0773af

    11-. "<div>abonneert op gebeurtenissen<br />met</div><div style='font-size: 70%'></div>" .->2
    2-. "<div>muteert gegevens van personen</div><div style='font-size: 70%'></div>" .->1
    1-. "<div>afvangen van persoon mutaties</div><div style='font-size: 70%'></div>" .->2
  end```
