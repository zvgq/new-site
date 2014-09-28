express = require "express"
nconf	= require "nconf"

repositories = require "../repositories"

class ApiRouter
	constructor: ()->
		gameTableName 	= nconf.get "GAME_TABLE_NAME"
		quoteTableName	= nconf.get "QUOTE_TABLE_NAME"
		accountName 	= nconf.get "STORAGE_NAME"
		accountKey 		= nconf.get "STORAGE_KEY"

		# setup router
		@router = express.Router()

		# create link to repo
		gamesRepo = new repositories.GamesRepository(accountName, accountKey)
		
		# private functions
		retrieveGames = (req, res)->
			gamesRepo.getGames '', false
		
		# setup routes
		@router.get "/games", retrieveGames

		

		#@router.get "/games/:title", gamesRepo.get
		
		# setup quote routes
		# quotesRepo = new repositories.QuotesRepository(quoteTableName, accountName, accountKey)
		
		#@router.get "/quotes/:gameId", quotesRepo.listByGameId

module.exports = ApiRouter
