export class ProblemDetails {
  type: string;
  status: number;
  title?: string;
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
}

export class UnauthorizedProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super('https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.2', 401, title, detail, instance);
  }
}

export class ConflictProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super('https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.10', 409, title, detail, instance);
  }
}

export class NotFoundProblemDetails extends ProblemDetails {
  constructor(title?: string, detail?: string, instance?: string) {
    super('https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.5', 404, title, detail, instance);
  }
}
