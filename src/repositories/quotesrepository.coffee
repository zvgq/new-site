azure = require "azure-storage"
nconf = require "nconf"

QuoteModel = require "../models/quotemodel"

class QuotesRepository
	# constructor
	constructor: ()->
		# optimize when this loaded and shared amongst repositories
		nconf.load()
		accountKey = nconf.get "STORAGE_KEY"
		accountName = nconf.get "STORAGE_NAME"
		@tableName = nconf.get "QUOTE_TABLE_NAME"
        
		@tableService = azure.createTableService accountName, accountKey
		@tableService.createTableIfNotExists @tableName, (error, result, response)->
			if error
				console.log "Error createIfNotExists 'quotes' table in QuotesRepository"
				
	getQuotesByGameId: (gameId, callback)->
		# TODO: get quotes based on gameId
		query = new azure.TableQuery()
			.select ["RowKey", "gameId", "shortName", "text", "titleMediaUri"]
			.top 10
			
		@tableService.queryEntities @tableName, query, null, (error, result)->
			if error
				console.log "Error occurred with code #{ error.code } and statusCode #{ error.statusCode }"
				callback error, null
			else
				results = new QuoteModel entry for entry in result.entries
				callback null, results
		
module.exports = QuotesRepository		