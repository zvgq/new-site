express = require "express"
http	= require "http"
nconf	= require "nconf"

class WWWRouter
	constructor: ()->
		@router = express.Router()

		@router.get "/", (req, res, next)=>
			res.redirect "/games"

		@router.get "/faq", (req, res, next)=>
			data =
				title: "ZVGQ - FAQ"
				analytics: nconf.get "GOOGLE_TRACKING_CODE"
				version: req.app.locals.version
			res.render "faq", data

		@router.get "/games", (req, res, next)=>
			data =
				title: "ZVGQ - Games"
				analytics: nconf.get "GOOGLE_TRACKING_CODE"
				version: req.app.locals.version
			res.render "games", data

		@router.get "/game", (req, res, next)=>
			res.redirect "/games"

		@router.get "/game/:id", (req, res, next)=>
			data =
				title: "ZVGQ - Game"
				analytics: nconf.get "GOOGLE_TRACKING_CODE"
				version: req.app.locals.version
			res.render "game", data

module.exports = WWWRouter
