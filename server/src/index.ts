import express from "express";

const app = express();
const port = 8080 ?? process.env.PORT;

app.get("/healthz", (req, res) => {
  res.sendStatus(200);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
