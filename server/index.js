const express = require('express')
const { csvStringToJson } = require("./parsers");
const app = express()
const port = 3000

app.use(express.text())

const metrics = [];

app.post('/csv', (req, res) => {
  console.log(new Date().toLocaleString(), " - data received:\n");
  const json = csvStringToJson(req.body);
  const result = (JSON.parse(json)[0]);
  metrics.push(result);
  return res.send("ok");
})

app.get('/metrics', (req, res) => {
  let list = [ ...metrics];
  list.sort(function(a, b){return b.timestamp - a.timestamp}); 
  return res.json(list[0]);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})