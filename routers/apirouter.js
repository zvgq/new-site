(function() {
  var ApiRouter, express, nconf, repositories;

  express = require("express");

  nconf = require("nconf");

  repositories = require("../repositories");

  ApiRouter = (function() {
    function ApiRouter() {
      var accountKey, accountName, gameTableName, gamesRepo, quoteTableName, retrieveGames;
      gameTableName = nconf.get("GAME_TABLE_NAME");
      quoteTableName = nconf.get("QUOTE_TABLE_NAME");
      accountName = nconf.get("STORAGE_NAME");
      accountKey = nconf.get("STORAGE_KEY");
      this.router = express.Router();
      gamesRepo = new repositories.GamesRepository(accountName, accountKey);
      retrieveGames = function(req, res) {
        return gamesRepo.getGames(req.query.filter, true, function(error, games) {
          if (!error) {
            return res.status(200).json({
              "games": games
            });
          } else {
            return res.status(500).json({
              "error": 'An error occured in retrieveGames'
            });
          }
        });
      };
      this.router.param("filter", function(req, res, next, filter) {
        console.log(filter);
        return next();
      });
      this.router.get("/games", retrieveGames);
      this.router.get("/games/:filter", retrieveGames);
    }

    return ApiRouter;

  })();

  module.exports = ApiRouter;

}).call(this);
