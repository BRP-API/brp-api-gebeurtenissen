package nl.rvig.brpapi.gebeurtenissenmock.helpers

import nl.rvig.brpapi.gebeurtenissenmock.generated.model.Adres
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.Gebeurtenis
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.Overleden
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.OverledenData
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.Overlijden
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.VerblijfplaatsBuitenland
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.VerhuisdIntergemeentelijk
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.VerhuisdIntergemeentelijkData
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.VerhuisdNaarBuitenland
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.VerhuisdNaarBuitenlandData
import java.util.UUID

private const val CLOUDEVENTSSOURCE = "brp-api-gebeurtenissen"
private const val CLOUDEVENTSVERSION = "1.0"

public fun toOverledenGebeurtenis(burgerservicenummer: String, datum: String): Overleden = Overleden(
    data = OverledenData(
        burgerservicenummer = burgerservicenummer,
        overlijden = Overlijden(
            datum = toBrpApiDatum(datum)
        )
    ),
    id = UUID.randomUUID(),
    source = CLOUDEVENTSSOURCE,
    specversion = CLOUDEVENTSVERSION,
    type = ""
)

public fun toVerhuisdNaarBuitenlandGebeurtenis(burgerservicenummer: String, datumVan: String): VerhuisdNaarBuitenland = VerhuisdNaarBuitenland(
    data = VerhuisdNaarBuitenlandData(
        burgerservicenummer = burgerservicenummer,
        verblijfplaats = VerblijfplaatsBuitenland(
            datumVan = toBrpApiDatum(datumVan),
        )
    ),
    id = UUID.randomUUID(),
    source = CLOUDEVENTSSOURCE,
    specversion = CLOUDEVENTSVERSION,
    type = "",
)

public fun toVerhuisdIntergemeentelijkGebeurtenis(burgerservicenummer: String, datumVan: String): Gebeurtenis = VerhuisdIntergemeentelijk(
    data = VerhuisdIntergemeentelijkData(
        burgerservicenummer = burgerservicenummer,
        verblijfplaats = Adres(
            datumVan = toBrpApiDatum(datumVan),
        )
    ),
    id = UUID.randomUUID(),
    source = CLOUDEVENTSSOURCE,
    specversion = CLOUDEVENTSVERSION,
    type = ""
)
