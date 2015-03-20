express = require "express"
http	= require "http"
nconf	= require "nconf"

GameRepository = require "../repositories/gamerepository"

class WWWRouter
	constructor: ()->
		@router = express.Router()
		try
			@gamesRepo = new GameRepository();
		catch ex
			throw ex

		@router.get "/", (req, res, next)=>
			res.redirect "/games"

		@router.get "/faq", (req, res, next)=>
			data =
				title: "ZVGQ - FAQ"
				analytics: nconf.get "GOOGLE_TRACKING_CODE"
				version: req.app.locals.version
			res.render "faq", data

		getGames = (req, res, next)=>
			filter = if req.params.filter then req.params.filter else 'new'
			@gamesRepo.getGames filter, (err, results)->
				data =
					title: "ZVGQ - Games"
					analytics: nconf.get "GOOGLE_TRACKING_CODE"
					version: req.app.locals.version
					games: results.entries
				if(err)
					res.status(500).json(err)
				else
					res.render "games", data

				next()
		@router.get "/games", getGames
		@router.get "/games/:filter", getGames

		# /game
		@router.get "/game", (req, res, next)=>
			res.redirect "/games"

		@router.get "/game/:id", (req, res, next)=>
			data =
				title: "ZVGQ - Game"
				analytics: nconf.get "GOOGLE_TRACKING_CODE"
				version: req.app.locals.version
			res.render "game", data

module.exports = WWWRouter