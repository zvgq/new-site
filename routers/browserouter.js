(function() {
  var BrowseRouter, express, http;

  express = require("express");

  http = require("http");

  BrowseRouter = (function() {
    function BrowseRouter() {
      this.router = express.Router();
      this.router.get("/", (function(_this) {
        return function(req, res, next) {
          return res.render("browse", {
            title: "ZVGQ - Browse"
          });
        };
      })(this));
    }

    return BrowseRouter;

  })();

  module.exports = BrowseRouter;

}).call(this);
