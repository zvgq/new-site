azure = require "azure"

QuoteModel = require "../models/quotemodel"

class QuotesRepository
	# constructor
	constructor: (@storageClient, @partitionKey, @tableName)->
		@storageClient.createTableIfNotExists @tableName, (error)->
			if error
				throw error
				
	listByGameId: (req, res)=>
		query = null

		if req.params.gameId
			gameId = req.params.gameId
			
			query = azure.TableQuery
						.select()
						.from 'quotes'
						.where 'gameId eq ?', gameId

			@storageClient.queryEntities query, (error, entities)->
				if not error
					results = []
					for e in entities 
						do (e)->
							results.push(new QuoteModel(e))

					console.log "Entities returned #{ entities.length }"
					res.json(200, results)
				else
					console.log "Error occurred with code #{ error.code } and statusCode #{ error.statusCode }"
					res.send 500
					
		else
			msg = "No GameId provided with request"
			console.log msg
			res.send 500, msg
			
				
module.exports = QuotesRepository