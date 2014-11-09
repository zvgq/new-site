(function() {
  var GameModel, GamesRepository, QuotesRepository, azure,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  azure = require("azure-storage");

  GameModel = require("../models/gamemodel");

  QuotesRepository = require("./quotesrepository");

  GamesRepository = (function() {
    function GamesRepository(accountName, accountKey) {
      this.getGames = __bind(this.getGames, this);
      this.tableName = 'games';
      this.tableService = azure.createTableService(accountName, accountKey);
      this.tableService.createTableIfNotExists(this.tableName, function(error, result, response) {
        if (error) {
          return console.log("Error createIfNotExists 'games' table in GamesRepository");
        }
      });
    }

    GamesRepository.prototype.getGames = function(filter, withQuotes, callback) {
      var done, error, gameQuery, getNextCharacter, results;
      getNextCharacter = function(character) {
        return String.fromCharCode(filter.charCodeAt(filter.length - 1) + 1);
      };
      results = [];
      error = null;
      done = (function(_this) {
        return function() {
          return callback(error, results);
        };
      })(this);
      if (filter === 'new') {
        gameQuery = new azure.TableQuery().top(50).where('PartitionKey eq ?', 'zvgq-game');
      } else if (filter === 'num') {

      } else {
        gameQuery = new azure.TableQuery().where('PartitionKey eq ?', 'zvgq-game').and('title ge ?', filter.toUpperCase()).and('title lt ?', getNextCharacter(filter).toUpperCase()).or('title ge ?', filter).and('title lt ?', getNextCharacter(filter));
      }
      return this.tableService.queryEntities('games', gameQuery, null, (function(_this) {
        return function(gameQueryError, entities) {
          var addResult, completeCount, game, getQuotes, quotesRepo, _i, _j, _len, _len1, _ref, _results;
          if (!error) {
            addResult = function(sourceEntity) {
              var newGame;
              newGame = new GameModel(sourceEntity);
              return results.push(newGame);
            };
            _ref = entities.entries;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              game = _ref[_i];
              addResult(game);
            }
          } else {
            error = gameQueryError;
          }
          if (withQuotes === true) {
            quotesRepo = new QuotesRepository(_this.tableService);
            completeCount = 0;
            getQuotes = function(game) {
              return quotesRepo.getQuotesForGame(game.id, (function(_this) {
                return function(quoteQueryError, quoteEntities) {
                  if (!error) {
                    game.quotes = quoteEntities;
                  } else {
                    error = quoteQueryError;
                  }
                  completeCount++;
                  if (completeCount === results.length) {
                    return done();
                  }
                };
              })(this));
            };
            _results = [];
            for (_j = 0, _len1 = results.length; _j < _len1; _j++) {
              game = results[_j];
              _results.push(getQuotes(game));
            }
            return _results;
          } else {
            return done();
          }
        };
      })(this));
    };

    return GamesRepository;

  })();

  module.exports = GamesRepository;

}).call(this);
