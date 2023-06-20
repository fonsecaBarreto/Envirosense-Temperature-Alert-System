const path = require("path");
const cors = require("cors");
var fs = require("fs");
var music = "./public/beep.mp3"; // filepath
var stat = fs.statSync(path.resolve(__dirname, "public", "beep.mp3"));

const express = require("express");
const { Metrics } = require("./src/metrics.model");

const port = process.env.PORT || 3000;
const app = express();
app.use(express.json());

app.use(cors());
app.use((req, res, next) => {
  console.log("\n", new Date().toLocaleString(), " >", req.method, req.path);
  next();
});

app.use("/", express.static(path.resolve(__dirname, "public")));

const metrics = [Metrics(90, 36)];

app.get("/", (req, res) => {
  return res.json("ok");
});

app.post("/json", (req, res) => {
  const { body } = req;
  const dto = Metrics(body.humidity, body.temperature);
  console.log("new data: ", dto);
  metrics.push(dto);
  return res.send("ok");
});

app.get("/metrics", (req, res) => {
  let list = [...metrics];
  return res.json(list[list.length - 1]);
});

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
