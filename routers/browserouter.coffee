express = require "express"
http	= require "http"	

class BrowseRouter
	constructor: ()->
		@router = express.Router()
		@router.get "/", (req, res, next)=>	
			res.render "browse", { title: "ZVGQ - Browse" }

module.exports = BrowseRouter