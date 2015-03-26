'use strict';

var azure 			= require('azure-storage')
	, moment 		= require('moment')
	, nconf 		= require('nconf')
	, GameModel 	= require('../models/gamemodel')
	, QuoteModel 	= require('../models/quotemodel');

function GameRepository() {
	var accountName	= nconf.get("STORAGE_NAME")
		, accountKey = nconf.get("STORAGE_KEY")
		, tableName = nconf.get("CATALOGUE_TABLE_NAME");

	this.dataService = azure.createTableService(accountName, accountKey);
	this.dataService.createTableIfNotExists(tableName, function(err, result) {
		if(err) {
			throw(new Error(err));
		}
	});
};

// Private Functions
var getNextCharacter = function(char) {
	return String.fromCharCode(char.charCodeAt(0)+1);
}

var getNewQuery = function() {
		var newContentDays	= nconf.get("NEW_CONTENT_DAYS")
			, startDate 	= moment().subtract(newContentDays,'days').toDate();

		return new azure.TableQuery()
					.where("PartitionKey eq ?", "zvgq-game")
					.and("Timestamp >= ?date?", startDate)
	}

var getNumberQuery = function() {
	return new azure.TableQuery()
		.where("PartitionKey eq ?", "zvgq-game")
		.and("title >= ? and title < ?", "0", getNextCharacter('9'))
}

var getLetterQuery = function(letter) {
	var filter = letter.toLowerCase();
	return new azure.TableQuery()
		.where('PartitionKey eq ?', 'zvgq-game')
		.and('RowKey >= ? and RowKey < ?', filter, getNextCharacter(filter))
}

// Static Functions
GameRepository.validateFilter = function validateFilter(toValidate) {
	var validFilterRegex = /(num|new|^[a-zA-Z]{1}$)/g;

	return validFilterRegex.test(toValidate);
};

// Prototype
GameRepository.prototype.getGames = function(filter, callback) {
	var err, query, processed, retVal;

	function processEntries(element, index, array) {
		processed.push(GameModel.createModelFromAzureEntry(element));
	}

	if(GameRepository.validateFilter(filter)) {
		// select filter
		switch(filter) {
			case "new":
				query = getNewQuery();
				break;
			case "num":
				query = getNumberQuery();
				break;
			default:
				query = getLetterQuery(filter);
				break;
		}

		this.dataService.queryEntities("catalogue", query, null, function(err, result) {
			// handle error
			if(err) {
				callback(err, null);
			}
			else {
				// process entries
				processed = [];
				result.entries.forEach(processEntries);

				retVal = {};
				retVal.filter = filter;
				retVal.entries = processed;

				callback(err, retVal);
			}
		});
	}
	else {
		err = "Invalid filter: '" + filter + "'";
		retVal = null;

		callback(err, retVal);
	}
}

GameRepository.prototype.getGame = function(id, withQuotes, callback) {
	var dataService = this.dataService
		, processResult
		, quotes
		, quoteQuery;

	function processQuotes(element, index, array) {
		quotes.push(QuoteModel.createModelFromAzureEntry(element));
	}

	function retrieveEntitySuccess(err, result) {
		if(err) {
			// exit on error
			callback(err, null);
		}

		// convert to GameModel
		processResult = GameModel.createModelFromAzureEntry(result);

		// add quotes to GameModel
		if(withQuotes === true) {
			var quoteQuery = new azure.TableQuery()
								.where("PartitionKey eq ? and gameId eq ?", "zvgq-quote", processResult.id);

			dataService.queryEntities("catalogue", quoteQuery, null, function(err, result) {
				quotes = [];
				result.entries.forEach(processQuotes);

				processResult.quotes = quotes;
				// return with quotes
				callback(null, processResult);
			});
		}
		else {
			// return result without quotes
			callback(null, processResult);
		}
	};

	if(!GameModel.validateId(id)) {
		callback("invalid id: ".concat(id), null);
	}
	else {
		dataService.retrieveEntity('catalogue', 'zvgq-game', id, retrieveEntitySuccess);
	}
};

module.exports = GameRepository;
