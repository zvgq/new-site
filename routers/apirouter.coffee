express = require "express"
nconf	= require "nconf"
_ = require "underscore"

repositories = require "../repositories"

class ApiRouter
	constructor: (app)->
		accountName 		= nconf.get "STORAGE_NAME"
		accountKey 		= nconf.get "STORAGE_KEY"

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
					
		retrieveGame = (req, res)->
			gamesRepo.getGame req.param('game_id'), true, (error, game)->
				if not error
					res.status(200).json(game)
				else
					res.status(500).json({"error": "An error occured in apirouter.retrieveGames(req, res)"})
		
		isValidRequest = (req)->
			isValid = false;
			
			acceptedReferrers = nconf.get "REFERRERS"
			referrer = req.get "Referrer"
			
			if referrer isnt undefined
				findReferrerHost = (refHost)->
					if referrer.indexOf(refHost) > -1
						isValid = true
					
				_.each acceptedReferrers, findReferrerHost
			
			return isValid;
		
		# block based on referrer
		@router.use (req, res, next)->
			environment = app.get "env"
			 
			if environment is "development" or environment is "dev"
				next()
			else if isValidRequest(req) 
				next()
			else
				res.status(403).json({"error": "Forbidden"})
		
		# setup params
		@router.param "filter", (req, res, next, filter)->
			console.log filter
			next()
		
		# setup routes
		@router.get "/games", retrieveGames
		@router.get "/games/:game_id", retrieveGame

module.exports = ApiRouter
