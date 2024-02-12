import type { ErrorRequestHandler } from 'express';
import { ZodError } from 'zod';
import { fromZodError } from 'zod-validation-error';
import { ServiceError } from './errors';

export const errorHandler: ErrorRequestHandler = (error, req, res, next) => {
  if (error instanceof ZodError) {
    const { message } = fromZodError(error);
    return res.status(400).json({ error: message });
  }

  if (error instanceof ServiceError) {
    console.error({ error: error.message, subError: error.subError });
    return res.status(502).json({ error: 'Bad Gateway' });
  }

  if (error instanceof Error) {
    return res.status(500).json({ error: 'Unexpected Error' });
  }

  next(error);
};
