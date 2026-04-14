export class ProblemDetails {
    type: string;
    title?: string;
    status: number;
    detail?: string;
    instance?: string;

    constructor(type: string, status: number, title?: string, detail?: string, instance?: string) {
        this.type = type;
        this.status = status;
        if (title) {
            this.title = title;
        }
        if (detail) {
            this.detail = detail;
        }
        if (instance) {
            this.instance = instance;
        }
    }

    static create(status: string): ProblemDetails | null {
        const statuscode = status.split(' ')[0];

        switch (statuscode) {
            case '400':
                return new BadRequestProblemDetails();
            case '401':
                return new UnauthorizedProblemDetails();
            case '404':
                return new NotFoundProblemDetails();
            case '409':
                return new ConflictProblemDetails();
            default:
                return null;
        }
    }
}

class BadRequestProblemDetails extends ProblemDetails {
    constructor(title?: string, detail?: string, instance?: string) {
        super(
            "https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.1",
            400,
            title,
            detail,
            instance
        );
    }
}

class UnauthorizedProblemDetails extends ProblemDetails {
    constructor(title?: string, detail?: string, instance?: string) {
        super(
            "https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.2",
            401,
            title,
            detail,
            instance
        );
    }
}
    
class NotFoundProblemDetails extends ProblemDetails {
    constructor(title?: string, detail?: string, instance?: string) {
        super(
            "https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.5",
            404,
            title,
            detail,
            instance
        );
    }
}

class ConflictProblemDetails extends ProblemDetails {
    constructor(title?: string, detail?: string, instance?: string) {
        super(
            "https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.10",
            409,
            title,
            detail,
            instance
        );
    }
}
