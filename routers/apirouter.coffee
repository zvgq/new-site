express = require "express"
nconf	= require "nconf"

repositories = require "../repositories"

class ApiRouter
	constructor: ()->
		accountName 		= nconf.get "STORAGE_NAME"
		accountKey 			= nconf.get "STORAGE_KEY"

		# setup router
		@router = express.Router()

		# create link to repo
		gamesRepo = new repositories.GamesRepository(accountName, accountKey)
		
		# private functions
		retrieveGames = (req, res)->
			gamesRepo.getGames req.query.filter, true, (error, games)->
				if not error
					res.status(200).json({"games": games})
				else
					res.status(500).json({"error": 'An error occured in retrieveGames'})
		
		# setup params
		@router.param "filter", (req, res, next, filter)->
			console.log filter
			next()
		
		# setup routes
		@router.get "/games", retrieveGames
		@router.get "/games/:filter", retrieveGames

module.exports = ApiRouter
