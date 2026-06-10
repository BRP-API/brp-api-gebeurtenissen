export class ProblemDetails {
  type: string;
  title?: string;
  status: number;
  detail?: string;
  instance?: string;

  constructor(
    type: string,
    status: number,
    title?: string,
    detail?: string,
    instance?: string,
  ) {
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

  static getStatusCode(status: string): number {
    return +status.split(' ')[0];
  }

  static isSuccessFull(statusCode: number): boolean {
    return statusCode >= 200 && statusCode < 300;
  }

  static create(status: string): ProblemDetails | null {
    const statuscode = this.getStatusCode(status);

    switch (statuscode) {
      case 400:
        return new BadRequestProblemDetails();
      case 401:
        return new UnauthorizedProblemDetails();
      case 404:
        return new NotFoundProblemDetails();
      case 409:
        return new ConflictProblemDetails();
      default:
        return null;
    }
  }
}

class BadRequestProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super(
      'https://www.rfc-editor.org/rfc/rfc9110.html#name-400-bad-request',
      400,
      title,
      detail,
      instance,
    );
  }
}

class UnauthorizedProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super(
      'https://www.rfc-editor.org/rfc/rfc9110.html#name-401-unauthorized',
      401,
      title,
      detail,
      instance,
    );
  }
}

class NotFoundProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super(
      'https://www.rfc-editor.org/rfc/rfc9110.html#name-404-not-found',
      404,
      title,
      detail,
      instance,
    );
  }
}

class ConflictProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super(
      'https://www.rfc-editor.org/rfc/rfc9110.html#name-409-conflict',
      409,
      title,
      detail,
      instance,
    );
  }
}
