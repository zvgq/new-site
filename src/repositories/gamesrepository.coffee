azure = require "azure-storage"

GameModel = require "../models/gamemodel"

class GamesRepository
	# constructor
	constructor: (accountName, accountKey)->
        @tableName = 'games'
        
        @tableService = azure.createTableService accountName, accountKey
        @tableService.createTableIfNotExists @tableName, (error, result, response)->
            if error
                console.log "Error createIfNotExists 'games' table in GamesRepository"

	# Public Functions
	# callback, function (error, games)
	getGames: (filter, withQuotes, callback)=>
		results = []
		
		# create gameQuery
		# TODO: Include filter in query
		gameQuery = new azure.TableQuery()
					.top 10
					.where 'PartitionKey eq ?', 'zvgq-game'
					
		@tableService.queryEntities 'games', gameQuery, null, (error, entities)=>
			if not error
				# create game models
				addGame = (sourceEntity)->
					newGame = new GameModel sourceEntity
					results.push newGame
				
				addGame game for game in entities.entries

			else
				console.log "Error Game Query"
				
			callback error, results

module.exports = GamesRepository
