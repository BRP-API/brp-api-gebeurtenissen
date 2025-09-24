package nl.brp.api.gebeurtenissen.web.validation;

public interface Specification<T> {
    /**
     * Check if the candidate satisfies the specification.
     * @param candidate
     * @return
     */
    boolean isSatisfiedBy(T candidate);
}
