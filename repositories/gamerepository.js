'use strict';

var azure = require('azure-storage')
	, nconf = require('nconf');

function GameRepository() {
	var accountName	= nconf.get("STORAGE_NAME")
		, accountKey = nconf.get("STORAGE_KEY")
		, tableName= nconf.get("CATALOGUE_TABLE_NAME");

	azure.createTableService();
};

module.exports = GameRepository;
