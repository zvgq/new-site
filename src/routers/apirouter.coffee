express = require "express"
nconf	= require "nconf"

repositories = require "../repositories"

class ApiRouter
	constructor: ()->
		gameTableName 	= nconf.get "GAME_TABLE_NAME"
		accountName 	= nconf.get "STORAGE_NAME"
		accountKey 		= nconf.get "STORAGE_KEY"

		# setup router
		@router = express.Router()

		# setup game routes
		gamesRepo = new repositories.GamesRepository(gameTableName, accountName, accountKey)

		@router.get "/games", gamesRepo.list
		#@router.get "/games/:title", gamesRepo.get
		
		# setup quote routes
		#quotesRepo = new repositories.QuotesRepository(@storageClient, partitionKey, quoteTableName)
		
		#@router.get "/quotes/:gameId", quotesRepo.listByGameId

module.exports = ApiRouter
