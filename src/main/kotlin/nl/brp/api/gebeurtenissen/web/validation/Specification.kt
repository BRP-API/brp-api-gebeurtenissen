package nl.brp.api.gebeurtenissen.web.api

interface Specification<T> {
    /**
     * Check if the candidate satisfies the specification.
     * @param candidate
     * @return
     */
    fun isSatisfiedBy(candidate: T): Boolean
}