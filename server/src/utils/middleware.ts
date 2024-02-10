import type { ErrorRequestHandler } from 'express';
import { ZodError } from 'zod';
import { fromZodError } from 'zod-validation-error';

export const errorHandler: ErrorRequestHandler = (error, req, res, next) => {
  console.error({ error: error.message });

  if (error instanceof ZodError) {
    const { message } = fromZodError(error);
    return res.status(400).json({ error: message });
  }

  next(error);
};
