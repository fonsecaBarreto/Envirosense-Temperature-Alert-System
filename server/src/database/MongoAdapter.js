const { MongoClient } = require('mongodb');
const url = process.env.MONGO_URL;
const client = new MongoClient(url, {});
const dbName = 'myProject';

async function connectDatabase() {
    try{
        console.log('Connected to MongoDb ...');
        await client.connect();
        console.log('Ok');
    }catch(err){
        console.error('Failed to connect to the database:', err);
        throw err;
    }finally{
         // Close the connection when your application shuts down
        process.on('SIGINT', function() {
            client.close().then(() => {
            console.log('Connection closed');
            process.exit(0);
            });
        });
    }
}

module.exports ={ connectDatabase, client, dbName }
