(function() {
  var QuoteModel, QuotesRepository, azure, nconf,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  azure = require("azure-storage");

  nconf = require("nconf");

  QuoteModel = require("../models/quotemodel");

  QuotesRepository = (function() {
    function QuotesRepository(tableService) {
      this.getQuotesForGame = __bind(this.getQuotesForGame, this);
      var accountKey, accountName;
      if (tableService) {
        this.tableService = tableService;
      } else {
        nconf.load();
        accountKey = nconf.get("STORAGE_KEY");
        accountName = nconf.get("STORAGE_NAME");
        this.tableService = azure.createTableService(accountName, accountKey);
      }
      this.tableName = 'games';
      this.tableService.createTableIfNotExists(this.tableName, function(error, result, response) {
        if (error) {
          return console.log("Error createIfNotExists 'quotes' table in QuotesRepository");
        }
      });
    }

    QuotesRepository.prototype.getQuotesForGame = function(gameId, callback) {
      var error, query, results;
      results = [];
      error = null;
      query = new azure.TableQuery().where('PartitionKey eq ?', 'zvgq-quote').and('gameId eq ?', gameId);
      return this.tableService.queryEntities('games', query, null, (function(_this) {
        return function(error, entities) {
          var addResult, quote, _i, _len, _ref;
          if (!error) {
            addResult = function(entity) {
              var quote;
              quote = new QuoteModel(entity);
              return results.push(quote);
            };
            _ref = entities.entries;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              quote = _ref[_i];
              addResult(quote);
            }
          } else {
            console.log("Error on getQuotesForGames query");
          }
          return callback(error, results);
        };
      })(this));
    };

    return QuotesRepository;

  })();

  module.exports = QuotesRepository;

}).call(this);
