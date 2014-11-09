(function() {
  var apiRouter, bodyParser, browseRouter, engines, express, nconf, path, routers, server;

  bodyParser = require("body-parser");

  engines = require("consolidate");

  express = require("express");

  nconf = require("nconf");

  path = require("path");

  routers = require("./routers");

  nconf.env().file({
    file: 'config.json'
  });

  nconf.load();

  server = express();

  server.set("view engine", "jade");

  server.set("views", "" + __dirname + "/views");

  server.engine("jade", engines.jade);

  server.use(bodyParser.json());

  server.use(bodyParser.urlencoded({
    extended: true
  }));

  server.use(express["static"](path.join(__dirname, "/client")));

  apiRouter = new routers.ApiRouter();

  server.use("/api", apiRouter.router);

  browseRouter = new routers.BrowseRouter();

  server.use("/browse", browseRouter.router);

  server.use("/", function(req, res) {
    return res.redirect("/browse");
  });

  server.listen(3000);

  console.log("Listening on port 3000");

}).call(this);
