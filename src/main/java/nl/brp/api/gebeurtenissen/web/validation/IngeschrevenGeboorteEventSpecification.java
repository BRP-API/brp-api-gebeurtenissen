package nl.brp.api.gebeurtenissen.web.validation;

import nl.brp.api.gebeurtenissen.web.api.Event;
import nl.brp.api.gebeurtenissen.web.api.IngeschrevenGeboorteEvent;
import org.springframework.stereotype.Component;

@Component
public class IngeschrevenGeboorteEventSpecification implements Specification<Event> {
    @Override
    public boolean isSatisfiedBy(Event event) {
        if (!(event instanceof IngeschrevenGeboorteEvent geboorteEvent)) return false;
        if (geboorteEvent.getData() == null) return false;
        return geboorteEvent.getData().getPlId() != null;
    }
}
