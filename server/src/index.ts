import express from "express";
import "express-async-errors";

import locationService from "./services/locationService";
import { placesNearbySearchRequestSchema } from "./schemas/placesNearbySearchRequestSchema";
import { errorHandler } from "./utils/middleware";
import { port } from "./config";

const app = express();
app.use(express.json());

app.get("/nearbyCafes", async (req, res) => {
  const placesNearbySearchRequest =
    await placesNearbySearchRequestSchema.parseAsync(req.query);

  res.send(await locationService.getNearbyCafes(placesNearbySearchRequest));
});

app.get("/healthz", (req, res) => {
  res.sendStatus(200);
});

app.use(errorHandler);

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
