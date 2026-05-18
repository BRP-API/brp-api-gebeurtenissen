package nl.rvig.brpapi.gebeurtenissenmock.helpers

import nl.rvig.brpapi.gebeurtenissenmock.generated.model.*
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.Locale

fun toBrpApiDatum(datum: String): AbstractDatum {
    require(datum.length == 8 && datum.all { it.isDigit() }) {
        "datum must be exactly 8 digits in 'YYYYMMDD' format, got: '$datum'"
    }
    val jaar = datum.substring(0, 4).toInt()
    val maand = datum.substring(4, 6).toInt()
    val dag = datum.substring(6, 8).toInt()

    return when {
        jaar > 0 && maand > 0 && dag > 0 -> toVolledigeDatum(jaar, maand, dag)
        jaar > 0 && maand > 0 && dag == 0 -> toJaarMaandDatum(jaar, maand)
        jaar > 0 && maand == 0 && dag == 0 -> toJaarDatum(jaar)
        else -> toDatumOnbekend()
    }
}

fun toDatumOnbekend(): DatumOnbekend = DatumOnbekend(
    onbekend = true,
    langFormaat = "onbekend",
    type = "",
)

fun toJaarDatum(jaar: Int): JaarDatum = JaarDatum(
    jaar = jaar,
    langFormaat = jaar.toString(),
    type = ""
)

fun toJaarMaandDatum(jaar: Int, maand: Int): JaarMaandDatum = JaarMaandDatum(
    jaar = jaar,
    maand = maand,
    langFormaat = LocalDate.of(jaar, maand, 1).format(DateTimeFormatter.ofPattern("MMMM uuuu", Locale.of("nl"))),
    type = ""
)

fun toVolledigeDatum(jaar: Int, maand: Int, dag: Int): VolledigeDatum {
    val datum = LocalDate.of(jaar, maand, dag)
    return VolledigeDatum(
        datum,
        langFormaat = datum.format(DateTimeFormatter.ofPattern("d MMMM uuuu", Locale.of("nl"))),
        type = ""
    )
}
