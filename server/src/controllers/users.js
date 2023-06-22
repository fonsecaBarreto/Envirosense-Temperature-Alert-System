const { client, dbName } = require("../database/MongoAdapter");

const db = client.db(dbName);
const collectionName = "users";

async function addUser(email) {
  try {
    const result = await db.collection(collectionName).insertOne({ email });
    return result.insertedId;
  } catch (err) {
    console.error("Failed to save user:", err);
    throw err;
  }
}

async function listUsers() {
  try {
    const collection = db.collection(collectionName);
    const users = await collection.find({}).toArray();
    return users;
  } catch (err) {
    console.error("Failed to lists users:", err);
    throw err;
  }
}


async function findUser(userId) {
  try {
    const collection = db.collection(collectionName);
    const user = await collection.findOne({ _id: userId });
    return user;
  } catch (err) {
    console.error("Failed to find user:", err);
    throw err;
  }
}

async function findUserByEmail(email) {
  try {
    const user = await db.collection(collectionName).findOne({ email });
    return user;
  } catch (err) {
    console.error("Failed to find user:", err);
    throw err;
  }
}

module.exports = { addUser, listUsers, findUser, findUserByEmail };
