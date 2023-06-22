"use strict";
const nodemailer = require("nodemailer");

const { EMAIL, EMAIL_PASSWORD } = process.env;
const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  auth: {
    user: EMAIL,
    pass: EMAIL_PASSWORD,
  },
});

// async..await is not allowed in global scope, must use a wrapper
async function sendEmail(to) {
  console.log("Sending email here", EMAIL);
  const info = await transporter.sendMail({
    from: EMAIL,
    to,
    subject: "ALERTA DE SEGURANÇA", // Subject line
    text: "Temperatura esta acima do esperado", // plain text body
    html: "<b>Temperatura esta acima do esperado</b>", // html body
  });

  console.log("Message sent: %s", info.messageId);
}

module.exports = { sendEmail };
