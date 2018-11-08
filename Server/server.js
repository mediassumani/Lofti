
var express = require("express");
var http = require("http");
const app = express()


const data = {

    "spaces": [
      {
      "name": "Tea Tree Torte",
      "renter": "Make School",
      "description": "Cozy small place to work",
      "address": "555 Post Street, San Francisco, CA",
      "capacity": 4,
      "hasWifi": true,
      "price": 7
    },

    {
      "name": "Ozone Studion",
      "renter": "Trvor Phillips",
      "description": "Nice Cozy space to study",
      "address": "246 McAllister Ave, San Francisco, CA",
      "capacity": 3,
      "hasWifi": false,
      "price": 5
    },

    {
      "name": "Redwood Backlava",
      "renter": "Ann Spalding",
      "description": "Small tidy place to work",
      "address": "89 George Ave, San Francisco, CA",
      "capacity": 6,
      "hasWifi": true,
      "price": 5
    }
  ]
}

app.get("/api/v1/spaces", function(request, response){
  response.json(data).send()
});


app.listen(3000, function(){
  console.log("Lofti API listening on Port 3000")
});
