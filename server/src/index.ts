import express from "express";
import * as config from "./config"

const app = express();
const port = config.port;

app.get("/healthz", (req, res) => {
  res.sendStatus(200);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
