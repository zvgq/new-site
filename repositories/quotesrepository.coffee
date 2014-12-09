azure = require "azure-storage"
nconf = require "nconf"

QuoteModel = require "../models/quotemodel"

class QuotesRepository
	constructor: (tableService)->
		if tableService
			@tableService = tableService
		else
			nconf.load()
			accountKey = nconf.get "STORAGE_KEY"
			accountName = nconf.get "STORAGE_NAME"
			@tableService = azure.createTableService accountName, accountKey
		
		@catalogueTableName = nconf.get "CATALOGUE_TABLE_NAME"
		@tableService.createTableIfNotExists @catalogueTableName, (error, result, response)->
			if error
				console.log "Error createIfNotExists 'quotes' table in QuotesRepository"
				
	# callback, (error, results)
	getQuotesForGame: (gameId, callback)=>
		results = []
		error = null
			
		query = new azure.TableQuery()
							.where 'PartitionKey eq ?', 'zvgq-quote'
							.and 'gameId eq ?', gameId
				
		@tableService.queryEntities @catalogueTableName, query, null, (error, entities)=>
			if not error
				addResult = (entity)->
					quote = new QuoteModel entity
					results.push quote

				addResult quote for quote in entities.entries
			else
				console.log "Error on getQuotesForGames query"	
				
			# DONE -- use callback
			callback error, results
	
module.exports = QuotesRepository		