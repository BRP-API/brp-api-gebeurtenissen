package nl.brp.api.gebeurtenissen.web.api

data class PublishEventCommand(
    val id: String,
    val event: Event
)