package nl.brp.api.gebeurtenissen.web.api;

import nl.brp.api.gebeurtenissen.web.validation.Specification;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.List;

@Service
public class GebeurtenisApiDelegateService implements GebeurtenisApiDelegate {

    private final List<Specification<Event>> specifications;

    public GebeurtenisApiDelegateService(List<Specification<Event>> specifications) {
        this.specifications = specifications;
    }

    @Override
    public ResponseEntity<PublishEvent200Response> publishEvent(Event event) {
        if (event == null) return new ResponseEntity<>(HttpStatus.BAD_REQUEST);

        boolean anySatisfied = specifications.stream().anyMatch(spec -> spec.isSatisfiedBy(event));

        String result = anySatisfied ? UUID.randomUUID().toString() : "Invalid event type or specification mismatch";

        PublishEvent200Response response = new PublishEvent200Response();
        response.setId(result);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
