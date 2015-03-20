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

// Static Functions
GameRepository.validateFilter = function validateFilter(toValidate) {
	var validFilterRegex = /(num|new|^[a-zA-Z]{1}$)/g;

	return validFilterRegex.test(toValidate);
};

// Prototype
GameRepository.prototype.getGames = function getGames(filter, callback) {
	var err, query, processed, retVal;

	// helper functions
	function getNewQuery() {
		var newContentDays	= nconf.get("NEW_CONTENT_DAYS")
			, startDate 	= moment().subtract(newContentDays,'days').toDate();

		return new azure.TableQuery()
					.where("PartitionKey eq ?", "zvgq-game")
					.and("Timestamp >= ?date?", startDate)
	}

	function processEntries(element, index, array) {
		processed.push(GameModel.createModelFromAzureEntry(element));
	}

	if(GameRepository.validateFilter(filter.toLowerCase())) {
		query = getNewQuery();
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
