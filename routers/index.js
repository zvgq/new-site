(function() {
  var ApiRouter, BrowseRouter;

  ApiRouter = require("./apirouter");

  BrowseRouter = require("./browserouter");

  module.exports = {
    ApiRouter: ApiRouter,
    BrowseRouter: BrowseRouter
  };

}).call(this);
