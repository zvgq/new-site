azure = require "azure-storage"

GameModel = require "../models/gamemodel"
QuotesRepository = require "./quotesrepository"

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
		# TODO: move util functions to separate module
		getNextCharacter = (character)->
			return String.fromCharCode(character.charCodeAt(0)+1)
		
		results = []
		error = null;
		
		done = ()=>
			# DONE -- use callback	
			callback error, results
		
		# create gameQuery
		if filter == 'new'
			gameQuery = new azure.TableQuery()
			.top 50
			.where 'PartitionKey eq ?', 'zvgq-game'
		else if filter == 'num'
			gameQuery = new azure.TableQuery()
				.where 'PartitionKey eq ?', 'zvgq-game'
				.and 'title >= ? and title < ?', '0', getNextCharacter('9')
		else
			gameQuery = new azure.TableQuery()
						.where 'PartitionKey eq ?', 'zvgq-game'
						.and 'title ge ?', filter.toUpperCase()
						.and 'title lt ?', getNextCharacter(filter).toUpperCase()
						.or 'title ge ?', filter
						.and 'title lt ?', getNextCharacter(filter)
					
		@tableService.queryEntities 'games', gameQuery, null, (gameQueryError, entities)=>
			# Add games to Results
			if not error
				# create game models
				addResult = (sourceEntity)->
					newGame = new GameModel sourceEntity
					results.push newGame
				
				addResult game for game in entities.entries

			else
				error = gameQueryError
			
			# Add quotes to games, if requested
			if withQuotes == true							
				quotesRepo = new QuotesRepository @tableService
				completeCount = 0
				getQuotes = (game)->
					quotesRepo.getQuotesForGame game.id, (quoteQueryError, quoteEntities)=>
						if not error
							game.quotes = quoteEntities
						else
							error = quoteQueryError
						
						completeCount++
						if completeCount == results.length
							done()
						
				getQuotes game for game in results
			 
			else						
				done()

module.exports = GamesRepository
