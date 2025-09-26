package nl.brp.api.gebeurtenissen.web.api

import org.axonframework.commandhandling.CommandHandler
import org.axonframework.eventhandling.gateway.EventGateway
import org.springframework.stereotype.Service

@Service
class GebeurtenisCommandHandler(private val eventGateway: EventGateway) {

    @CommandHandler
    fun handle(command: PublishEventCommand) {
        eventGateway.publish(command)
    }
}

