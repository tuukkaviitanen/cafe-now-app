import express from "express";

const app = express();
const port = Number(process.env.PORT) ?? 8080;

app.get("/healthz", (req, res) => {
  res.sendStatus(200);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
