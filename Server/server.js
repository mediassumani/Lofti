if(!process.env.PORT){
  require('dotenv').config();
}

const express = require("express");
const mongoose = require("mongoose");
const http = require("http");
const port = process.env.PORT || 3000;
const app = express();




app.listen(port);
module.exports(app);
