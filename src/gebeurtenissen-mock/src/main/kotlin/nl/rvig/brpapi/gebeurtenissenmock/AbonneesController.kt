package nl.rvig.brpapi.gebeurtenissenmock

import nl.rvig.brpapi.gebeurtenissenmock.generated.api.AbonneesApi
import nl.rvig.brpapi.gebeurtenissenmock.generated.model.*
import nl.rvig.brpapi.gebeurtenissenmock.helpers.toOverledenGebeurtenis
import nl.rvig.brpapi.gebeurtenissenmock.helpers.toVerhuisdIntergemeentelijkGebeurtenis
import nl.rvig.brpapi.gebeurtenissenmock.helpers.toVerhuisdNaarBuitenlandGebeurtenis
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import java.util.UUID

@RestController
class AbonneesController : AbonneesApi {
    override fun bevraagGebeurtenis(
        abonneeNaam: String,
        cursor: UUID?,
        limit: Int?
    ): ResponseEntity<GebeurtenissenBevragenResponse> {
        val response = GebeurtenissenBevragenResponse(
            gebeurtenissen = listOf(
                toVerhuisdIntergemeentelijkGebeurtenis("123456789", "20240101"),
                toVerhuisdNaarBuitenlandGebeurtenis("987654321", "20240200"),
                toOverledenGebeurtenis("555555555", "00000000")
            ),
        )

        return ResponseEntity.ok(response)
    }

    override fun deregistreerAbonnee(abonneeNaam: String): ResponseEntity<Unit> {
        TODO("Not yet implemented")
    }

    override fun raadpleegAbonnees(): ResponseEntity<RaadpleegAbonneesResponse> {
        TODO("Not yet implemented")
    }

    override fun raadpleegAbonnementen(
        abonneeNaam: String,
        cursor: UUID?,
        limit: Int?
    ): ResponseEntity<RaadpleegAbonnementenResponse> {
        TODO("Not yet implemented")
    }

    override fun registreerAbonnee(registreerAbonneeCommand: RegistreerAbonneeCommand): ResponseEntity<Unit> {
        TODO("Not yet implemented")
    }

    override fun voeruitAbonnementenCommand(
        abonneeNaam: String,
        abonnementenCommand: AbonnementenCommand
    ): ResponseEntity<Unit> {
        TODO("Not yet implemented")
    }
}