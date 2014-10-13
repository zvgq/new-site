(function() {
  var GameModel, QuoteModel;

  GameModel = require("./gamemodel");

  QuoteModel = require("./quotemodel");

  module.exports = {
    GameModel: GameModel,
    QuoteModel: QuoteModel
  };

}).call(this);
