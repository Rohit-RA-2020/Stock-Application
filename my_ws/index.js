const WebSocket = require("ws");
const express = require("express");
const http = require("http");

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });



var stocks = [
  {
    image:"https://seeklogo.com/images/S/sbi-logo-744E8B0C10-seeklogo.com.png",
    symbol: "SBI",
    status: 12.1,
    name: "State Bank of India",
    price: 200,
    high: 205,
    low: 198,
  },
  {
    image:"https://assets.stickpng.com/thumbs/5ec3e22d58550c000442773b.png",
    symbol: "TATA",
    status: 10.1,
    name: "TATA Motors",
    price: 160,
    high: 177,
    low: 154,
  },
  {
    image:"https://companieslogo.com/img/orig/BPCL.NS-c7816451.png?t=1599628913",
    symbol: "BPCL",
    status: 5.7,
    name: "Bharat Petroleum",
    price: 277,
    high: 280,
    low: 200,
  },
  {
    image:"https://upload.wikimedia.org/wikipedia/commons/8/83/Titan_Company_Logo.png",
    symbol: "TITAN",
    status: 5.7,
    name: "Titan Company",
    price: 300,
    high: 250,
    low: 210,
  }
];

wss.on("connection", async function connection(ws) {
  ws.send("connected to server, welcome client");

  ws.on("message", function incoming(msg) {
    console.log("Recieved: %s", msg);
  });
});

// create a get route
app.get("/data", (req, res) => {
  res.send({
    "test": "stocks"
  });
});

function sendRandomData() {
  let randomNumber1 = Math.floor(Math.random() * 100);
  let randomNumber2 = Math.floor(Math.random() * 100);
  let randomNumber3 = Math.floor(Math.random() * 100);
  let randomNumber4 = Math.floor(Math.random() * 100);

  stocks[0]["price"] = randomNumber1;
  stocks[1]["price"] = randomNumber2;
  stocks[2]["price"] = randomNumber3;
  stocks[3]["price"] = randomNumber4;

  wss.clients.forEach(function each(client) {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(stocks));
    }
  });
}

server.listen(3000, () => {
  console.log('Server listening on port 3000');
});

setInterval(sendRandomData, 2000);
