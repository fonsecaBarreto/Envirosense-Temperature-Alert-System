const express = require('express')
const { csvStringToJson } = require("./parsers");
const app = express()
const port = process.env.PORT || 3000

app.use(express.text())

const metrics = [{ timestamp: 0, humidity: 90, temperature: 36 }];

app.get('/', (req, res) => {
  return res.json("ok");
})

app.post('/json', (req, res) => {
  console.log(topic, new Date().toLocaleDateString()," : " , payload.toString());
  const dto = JSON.parse(payload.toString());
  dto.timestamp = new Date();
  metrics.push(result);
  return res.send("ok");
})

app.get('/metrics', (req, res) => {
  let list = [ ...metrics];
  return res.json(list[list.length - 1]);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})