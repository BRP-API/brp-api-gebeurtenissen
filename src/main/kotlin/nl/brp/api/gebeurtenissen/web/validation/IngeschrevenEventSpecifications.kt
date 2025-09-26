package nl.brp.api.gebeurtenissen.web.validation

import nl.brp.api.gebeurtenissen.web.api.*
import org.springframework.stereotype.Component

@Component
class IngeschrevenGeboorteEventSpecifications : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
       val event = candidate as? IngeschrevenGeboorteEvent
       return event != null && event.data.plId != null
    }
}

@Component
class IngeschrevenImmigratieEventSpecifications : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
        val event = candidate as? IngeschrevenImmigratieEvent
        return event != null && event.data.plId != null
    }
}

@Component
class IngeschrevenNietIngezeteneEventSpecifications : Specification<Event> {
    override fun isSatisfiedBy(candidate: Event): Boolean {
        val event = candidate as? IngeschrevenNietIngezeteneEvent
        return event != null && event.data.plId != null
    }
}