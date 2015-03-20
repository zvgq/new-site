'use strict';

var azure 		= require('azure-storage')
	, moment 	= require('moment')
	, nconf 	= require('nconf')
	, GameModel = require('../models/gamemodel');

function GameRepository() {
	var accountName	= nconf.get("STORAGE_NAME")
		, accountKey = nconf.get("STORAGE_KEY")
		, tableName = nconf.get("CATALOGUE_TABLE_NAME");

	this.dataService = azure.createTableService(accountName, accountKey);
	this.dataService.createTableIfNotExists('games', function(err, result) {
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
GameRepository.prototype.getGames = function getGames(filter, callback) {
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

module.exports = GameRepository;
