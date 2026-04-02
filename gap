const http = require("http");

const MAKE_WEBHOOK = "https://hook.eu2.make.com/tam4yhf9t9khj8kftbhtly3c6xf8kx8n";

const server = http.createServer(async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");

  if (req.method === "OPTIONS") {
    res.writeHead(204);
    res.end();
    return;
  }

  if (req.method === "GET") {
    res.writeHead(200);
    res.end("Server is running!");
    return;
  }

  if (req.method === "POST") {
    let body = "";
    req.on("data", chunk => { body += chunk; });
    req.on("end", async () => {
      try {
        const { default: fetch } = await import("node-fetch");
        const makeRes = await fetch(MAKE_WEBHOOK, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: body
        });
        const text = await makeRes.text();
        res.writeHead(200, { "Content-Type": "application/json" });
