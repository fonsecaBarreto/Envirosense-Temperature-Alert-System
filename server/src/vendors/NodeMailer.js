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

var lastEmailSent = null;

async function sendEmail(to, ccs) {
  const agora = new Date().getTime();

  if (lastEmailSent != null && agora - lastEmailSent < 60000) {
    console.log("Envio bloqueado");
    return;
  }

  lastEmailSent = agora;
  const info = await transporter.sendMail({
    from: EMAIL,
    to,
    cc: ccs,
    subject: "ALERTA DE SEGURANÇA", // Subject line
    text: "Temperatura esta acima do esperado", // plain text body
    html: "<b>Temperatura esta acima do esperado</b>", // html body
  });
}

module.exports = { sendEmail };
