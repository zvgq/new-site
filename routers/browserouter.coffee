express = require "express"
http	= require "http"
nconf	= require "nconf"

class BrowseRouter
	constructor: ()->
		@router = express.Router()
		@router.get "/", (req, res, next)=>
			data = 
				title: "ZVGQ - Browse"
				analytics: nconf.get "GOOGLE_TRACKING_CODE"
			res.render "browse", data

module.exports = BrowseRouter