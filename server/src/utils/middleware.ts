import type { ErrorRequestHandler } from 'express';
import { ZodError } from 'zod';
import { fromZodError } from 'zod-validation-error';

export const errorHandler: ErrorRequestHandler = (error, req, res) => {
  console.error({ error: error.message });

  if (error instanceof ZodError) {
    const { message } = fromZodError(error);
    return res.status(400).json({ error: message });
  }

  return res.status(500).json({ error: 'unexpected error occured' });
};
