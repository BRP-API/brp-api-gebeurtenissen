package nl.brp.api.gebeurtenissen.web.api

import org.springframework.stereotype.Component

private fun isVerhuisdBinnenland(data: VerhuisdBinnenlandData) = data is VerhuisdBinnenlandData &&
        data.c08?.e1030 != null
private fun isVerhuisdBuitenland(data: VerhuisdBuitenlandData) = data is VerhuisdBuitenlandData &&
        data.c08?.e1310 == null &&
        data.c08?.e1320 == null &&
        data.c08?.e1330 == null &&
        data.c08?.e1340 == null &&
        data.c08?.e1350 == null

@Component
class VerhuisdBinnengemeentelijkEventSpecification : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
       val event = candidate as? VerhuisdBinnengemeentelijkEvent
       return event != null && event.data.plId != null && event.data.adresId != null && isVerhuisdBinnenland(event.data)
    }
}

@Component
class VerhuisdBuitengemeentelijkEventSpecification : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
        val event = candidate as? VerhuisdBuitengemeentelijkEvent
        return event != null && event.data.plId != null && event.data.adresId != null && isVerhuisdBinnenland(event.data)
    }
}

@Component
class VerhuisdImmigratieEventSpecification : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
        val event = candidate as? VerhuisdImmigratieEvent
        return event != null && event.data.plId != null && event.data.adresId != null && isVerhuisdBinnenland(event.data)
    }
}

@Component
class VerhuisdEmigratieEventSpecification : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
        val event = candidate as? VerhuisdEmigratieEvent
        return event != null && event.data.plId != null && isVerhuisdBuitenland(event.data)
    }
}

@Component
class VerhuisdInBuitenlandEventSpecification : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
        val event = candidate as? VerhuisdInBuitenlandEvent
        return event != null && event.data.plId != null && isVerhuisdBuitenland(event.data)
    }
}