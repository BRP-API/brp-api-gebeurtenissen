export class ProblemDetails {
  type: string;
  title: string;
  status: number;
  detail?: string;
  instance?: string;

  constructor(type: string, title: string, status: number, detail?: string, instance?: string) {
    this.type = type;
    this.title = title;
    this.status = status;
    if (detail) {
      this.detail = detail;
    }
    if (instance) {
      this.instance = instance;
    }
  }
}

export class UnauthorizedProblemDetails extends ProblemDetails {
  constructor(detail?: string, instance?: string) {
    super('https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.2', 'Niet correct geauthenticeerd', 401, detail, instance);
  }
}

export class ConflictProblemDetails extends ProblemDetails {
  constructor(detail?: string, instance?: string) {
    super('https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.10', 'Conflict', 409, detail, instance);
  }
}
