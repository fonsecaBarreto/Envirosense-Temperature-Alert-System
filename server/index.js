const express = require('express')
const { Metrics } = require("./src/metrics.model")

const port = process.env.PORT || 3000
const app = express()
app.use(express.json())

const metrics = [ Metrics(90,36) ];

app.get('/', (req, res) => {
  return res.json("ok");
})

app.post('/json', (req, res) => {
  const { body } = req;
  const dto = Metrics(body.humidity, body.temperature)
  console.log('new data: ', dto);
  metrics.push(dto);
  return res.send("ok");
})

app.get('/metrics', (req, res) => {
  let list = [ ...metrics];
  return res.json(list[list.length - 1]);
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})