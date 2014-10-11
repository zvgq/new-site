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
			gamesRepo.getGames '', true, (error, games)->
				if not error
					res.status(200).json({"games": games})
				else
					res.status(500).json({"error": 'An error occured in retrieveGames'})
		
		# setup routes
		@router.get "/games", retrieveGames

module.exports = ApiRouter
