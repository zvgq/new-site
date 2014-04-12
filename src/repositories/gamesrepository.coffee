azure = require "azure"

GameModel = require "../models/GameModel"

class GamesRepository
	# constructor
	constructor: (@storageClient, @tableName, @partitionKey)->
		@storageClient.createTableIfNotExists @tableName, (error)->
			if error
				throw error

	# Static Methods
	list: (req, res)=>
		query = null

		if req.params.letter
			letter = req.params.letter
			nextLetter = String.fromCharCode(letter.charCodeAt(0) + 1)
			
			query = azure.TableQuery
						.select()
						.from 'games'
						.where 'RowKey ge ?', letter
						.and 'RowKey lt ?', nextLetter
		else
			query = azure.TableQuery
						.select()
						.from 'games'
						.top 100

		@storageClient.queryEntities query, (error, entities)->
			if not error
				results = []
				for e in entities 
					do (e)->
						results.push(new GameModel(e))

				console.log "Entities returned #{ entities.length }"
				res.json(200, results)
			else
				console.log "Error occurred with code #{ error.code } and statusCode #{ error.statusCode }"
				res.send 500

	get: (req, res)=>
		rowKey = req.params.title

		@storageClient.queryEntity @tableName, @partitionKey, rowKey, (error, entity)->
			if not error
				result = new GameModel entity
				res.json 200, result
			else
				console.log "Error occurred with code #{ error.code } and statusCode #{ error.statusCode }"
				res.send 500

module.exports = GamesRepository