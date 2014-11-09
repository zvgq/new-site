(function() {
  var GamesRepository, QuotesRepository;

  GamesRepository = require("./gamesrepository");

  QuotesRepository = require("./quotesrepository");

  module.exports = {
    GamesRepository: GamesRepository,
    QuotesRepository: QuotesRepository
  };

}).call(this);
