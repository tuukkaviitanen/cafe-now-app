import express from 'express';
import 'express-async-errors';

import locationService from './services/locationService';
import { placesNearbySearchRequestSchema } from './schemas/placesNearbySearchRequestSchema';
import { errorHandler } from './utils/middleware';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import { nodeEnv } from './utils/environment';
const app = express();

app.use(express.json());
app.use(helmet());

if (nodeEnv === 'production') {
  app.use(
    rateLimit({
      windowMs: 15 * 60 * 1000, // 15 minutes in milliseconds
      max: 15, // Max number of requests allowed in that time frame
    }),
  );
}

app.get('/nearbyCafes', async (req, res) => {
  const placesNearbySearchRequest =
    await placesNearbySearchRequestSchema.parseAsync(req.query);

  res.send(await locationService.getNearbyCafes(placesNearbySearchRequest));
});

app.get('/healthz', (req, res) => {
  res.sendStatus(200);
});

app.use(errorHandler);

export default app;
