azure = require "azure"
express = require "express"
nconf	= require "nconf"

repositories = require "../repositories"

class ApiRouter
	constructor: ()->
		# nconf.file "../config.json"

		gameTableName 	= nconf.get "GAME_TABLE_NAME"
		partitionKey 	= nconf.get "PARTITION_KEY"
		accountName 	= nconf.get "STORAGE_NAME"
		accountKey 		= nconf.get "STORAGE_KEY"

		# initialize storage client
		@storageClient	= azure.createTableService(accountName, accountKey)

		# setup router
		@router = express.Router()

		# setup game routes
		gamesRepo = new repositories.GamesRepository(@storageClient, gameTableName, partitionKey)

		@router.get "/games", gamesRepo.list
		@router.get "/games/:title", gamesRepo.get

module.exports = ApiRouter
