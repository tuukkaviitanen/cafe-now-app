import express from "express";
import * as config from "./config"
import locationService from "./services/locationService";

const app = express();
const port = config.port;

app.get("/locations", async (req, res) => {
  res.send(await locationService.getNearbyCafes())
})

app.get("/healthz", (req, res) => {
  res.sendStatus(200);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
