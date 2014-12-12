azure = require "azure-storage"
nconf = require "nconf"

GameModel = require "../models/gamemodel"
QuotesRepository = require "./quotesrepository"

class GamesRepository
	# constructor
	constructor: (accountName, accountKey)->
        @catalogueTableName = nconf.get "CATALOGUE_TABLE_NAME"
        
        @tableService = azure.createTableService accountName, accountKey
        @tableService.createTableIfNotExists @catalogueTableName, (error, result, response)->
            if error
                console.log "Error createIfNotExists #{ @catalogueTableName } table in GamesRepository"

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
			upperCaseFilter = filter.toUpperCase()
			gameQuery = new azure.TableQuery()
				.where 'PartitionKey eq ?', 'zvgq-game'
				.and 'title >= ? and title < ?', filter, getNextCharacter(filter)
				.or 'title >= ? and title < ?', upperCaseFilter, getNextCharacter(upperCaseFilter)
					
		@tableService.queryEntities @catalogueTableName, gameQuery, null, (gameQueryError, entities)=>
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
			if withQuotes == true and results.length > 0						
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
	getGame: (game_id, withQuotes, done)=>
		error = null

		@tableService.retrieveEntity @catalogueTableName, 'zvgq-game', game_id, (error, result, response)=>		
			if withQuotes is true and response.body isnt null
				game = new GameModel response.body
				quotesRepo = new QuotesRepository @tableService
				quotesRepo.getQuotesForGame game.id, (quoteQueryError, quoteEntities)=>
					if not error
						game.quotes = quoteEntities
					else
						error = quoteQueryError
						
					done(error, game)
			else
				game = null
				error = "No game with id #{ game_id } was found!"
				done(error, game)

module.exports = GamesRepository
