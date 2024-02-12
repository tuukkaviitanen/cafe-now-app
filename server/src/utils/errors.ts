export class ServiceError extends Error {
  subError: Error;
  constructor(message: string, subError: Error) {
    super(message);
    this.name = 'ServiceError';
    this.subError = subError;
  }
}
