package nl.brp.api.gebeurtenissen.web.api

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import java.util.*

@Service
class GebeurtenisApiDelegateService(
        private val specifications: List<Specification<Event>>,
        private val commandHandler: GebeurtenisCommandHandler
    ) : GebeurtenisApiDelegate {
    override fun publishEvent(event: Event?): ResponseEntity<PublishEvent200Response> {
        if (event == null) return ResponseEntity(HttpStatus.BAD_REQUEST)

        val anySatisfied = specifications.stream().anyMatch { spec: Specification<Event> -> spec.isSatisfiedBy(event) }

        if(!anySatisfied) return ResponseEntity(HttpStatus.BAD_REQUEST)

        val result = UUID.randomUUID().toString()

        val command = PublishEventCommand(
            id = result,
            event = event
        )

        commandHandler.handle(command)

        val response = PublishEvent200Response(id = result)
        return ResponseEntity(response, HttpStatus.OK)
    }
}