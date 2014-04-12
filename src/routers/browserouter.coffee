azure = require "azure"
express = require "express"

class BrowseRouter
	constructor: ()->
		@router = express.Router()

		@router.get "/", (req, res, next)->
			res.render "index", { title: "Hello", body: "Hello again!"}

module.exports = BrowseRouter