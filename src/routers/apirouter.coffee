azure = require "azure"
express = require "express"
nconf	= require "nconf"

repositories = require "../repositories"

class ApiRouter
	constructor: ()->
		# nconf.file "../config.json"

		mediaTableName 	= nconf.get "MEDIA_TABLE_NAME"
		partitionKey 	= nconf.get "GAME_PARTITION_KEY"
		accountName 	= nconf.get "STORAGE_NAME"
		accountKey 		= nconf.get "STORAGE_KEY"

		# setup router
		@router = express.Router()

		# setup game routes
		gamesRepo = new repositories.GamesRepository(accountName, accountKey)

		@router.get "/games", gamesRepo.list
		#@router.get "/games/:title", gamesRepo.get
		
		# setup quote routes
		#quotesRepo = new repositories.QuotesRepository(@storageClient, partitionKey, quoteTableName)
		
		#@router.get "/quotes/:gameId", quotesRepo.listByGameId

module.exports = ApiRouter
