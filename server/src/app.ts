import express from 'express';
import 'express-async-errors';

import locationService from './services/locationService';
import { placesNearbySearchRequestSchema } from './schemas/placesNearbySearchRequestSchema';
import { errorHandler } from './utils/middleware';
import helmet from 'helmet';
import { ServiceError } from './utils/errors';
const app = express();

app.use(helmet());

app.use(express.json());

app.get('/nearbyCafes', async (req, res, next) => {
  const placesNearbySearchRequest =
    await placesNearbySearchRequestSchema.parseAsync(req.query);

  try {
    return res.send(
      await locationService.getNearbyCafes(placesNearbySearchRequest),
    );
  } catch (error) {
    if (error instanceof Error) {
      return next(new ServiceError('getNearbyCafes failed', error));
    }
    return next(error);
  }
});

app.get('/healthz', (req, res) => {
  return res.sendStatus(200);
});

app.use(errorHandler);

export default app;
