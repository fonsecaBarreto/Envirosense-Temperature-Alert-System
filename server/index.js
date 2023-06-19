const express = require('express')
const app = express()
const port = process.env.PORT || 3000

app.use(express.json())

const metrics = [{ timestamp: 0, humidity: 90, temperature: 36 }];

app.get('/', (req, res) => {
  return res.json("ok");
})

app.post('/json', (req, res) => {
  console.log('new data', req.body);
  const dto = req.body;
  dto.timestamp = new Date();
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