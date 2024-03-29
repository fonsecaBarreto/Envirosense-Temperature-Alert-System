const path = require("path");
const cors = require("cors");
const express = require("express");
const { connectDatabase } = require("./src/database/MongoAdapter");
const { Metrics } = require("./src/models/metrics");
const { addUser, listUsers, findUser, findUserByEmail } = require("./src/controllers/users");
const { addMetrics, listMetrics } = require("./src/controllers/metrics");
const { sendEmail } = require("./src/vendors/NodeMailer");
const port = process.env.PORT || 3000;

const app = express();
app.use(express.json());
app.use(cors());
app.use((req, res, next) => {
  console.log("\n", new Date().toLocaleString(), " >", req.method, req.path);
  next();
});

app.use("/", express.static(path.resolve(__dirname, "public")));

app.get("/", (req, res) => {
  return res.json("ok");
});

app
  .route("/metrics")
  .post(async (req, res) => {
    const { humidity, temperature } = req.body;
    if (!humidity || !temperature)
      return res.status(400).json("Metrica invalido");
    const dto = Metrics(humidity, temperature);

    await addMetrics(dto);

    if (temperature > 30) {
      console.log("ALERTA DE SEGURANÇA");
      try{
        const users = await listUsers();
        const emails = users
          .map((u) => u.email)
          .filter((email) => /\S+@\S+\.\S+/.test(email))
          .join(",");
  
        console.log("Enviando email para lucasfonsecab@hotmail.com");
        console.log("copiando para: " + emails);
        await sendEmail(
          "lucasfonsecab@hotmail.com", emails.length == 0 ? "" : emails
        );
        console.log("Sucesso!");
      }catch(err){
        console.error("Não foi possivel enviar alerta de segurança: \n", err);
      }
    }

    return res.send("ok");
  })
  .get(async (req, res) => {
    try {
      const metrics = await listMetrics();
      return res.json(metrics);
    } catch (err) {
      return res.status(500).send("INTERNAL ERROR");
    }
  });

app
  .route("/users")
  .get(async (req, res) => {
    try {
      const users = await listUsers();
      return res.json(users);
    } catch (err) {
      return res.status(500).send("INTERNAL ERROR");
    }
  })
  .post(async (req, res) => {
    try {
      const { email } = req.body;
      if (!email) return res.status(400).json("Email invalido");

      const userExists = await findUserByEmail(email);
      if(!!userExists) return res.json(userExists);

      const user = await addUser(email).then(findUser);
      return res.json(user);
    } catch (err) {
      console.log(err);
      return res.status(500).send("INTERNAL ERROR");
    }
  });

async function main() {
  console.log("Iniciando...");
  try {
    const client = await connectDatabase();
    console.log(client);
    app.listen(port, () => {
      console.log(`Listening on port ${port}`);
    });
  } catch (err) {
    console.log(":/");
  }
}

main();
