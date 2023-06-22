const { client, dbName } = require("../database/MongoAdapter");

const db = client.db(dbName);
const collectionName = "metrics";

async function addMetrics(metricsData) {
  try {
    const collection = db.collection(collectionName);
    const result =  await collection.insertOne(metricsData);
    return result.insertedId;
  } catch (err) {
    console.error("Failed to save metrics:", err);
    throw err;
  }
}

async function listMetrics() {
  try {
    const collection = db.collection(collectionName);
    const metrics = await collection.find({}).sort({ timestamp: -1 }).limit(5).toArray();
    return metrics;
  } catch (err) {
    console.error("Failed to lists metrics:", err);
    throw err;
  }
}


module.exports = { addMetrics, listMetrics };
