'use strict';

var azure = require('azure-storage')
	, nconf = require('nconf');

function GameRepository() {
	var accountName	= nconf.get("STORAGE_NAME")
		, accountKey = nconf.get("STORAGE_KEY")
		, tableName = nconf.get("CATALOGUE_TABLE_NAME");

	this.dataService = azure.createTableService();
};

// Static Functions
GameRepository.validateFilter = function validateFilter(toValidate) {
	var validFilterRegex = /(num|new|^[a-zA-Z]{1}$)/g;

	return validFilterRegex.test(toValidate);
};

// Prototype
GameRepository.prototype.getGames = function getGames(filter, callback) {
	var err, query, retVal;

	if(GameRepository.validateFilter(filter.toLowerCase())) {
		query = new azure.TableQuery()
					.where("PartitionKey eq ?", filter);
		this.dataService.queryEntities("games", query, null, function(err, result, response) {
			// handle error
			if(err) {
				callback(err, null);
			}
			else {
				retVal = {};
				retVal.filter = filter;
				retVal.results = entities;

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
