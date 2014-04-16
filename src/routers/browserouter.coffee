azure = require "azure"
express = require "express"

class BrowseRouter
	constructor: ()->
		@router = express.Router()
		@router.get "/", (req, res, next)=>
			res.render "browse", { title: "Hello", body: "Hello again!", filters: @filters }
			
	filters: [
		{ "description": "NEW", "filter": "new" }
		{ "description": "#", "filter": "num" }
		{ "description": "A", "filter": "a" }
		{ "description": "B", "filter": "b" }
		{ "description": "C", "filter": "c" }
		{ "description": "D", "filter": "d" }
		{ "description": "E", "filter": "e" }
		{ "description": "G", "filter": "g" }
		{ "description": "H", "filter": "h" }
		{ "description": "I", "filter": "i" }
		{ "description": "J", "filter": "j" }
		{ "description": "K", "filter": "k" }
		{ "description": "L", "filter": "l" }
		{ "description": "M", "filter": "m" }
		{ "description": "N", "filter": "n" }
		{ "description": "O", "filter": "o" }
		{ "description": "P", "filter": "p" }
		{ "description": "Q", "filter": "q" }
		{ "description": "R", "filter": "r" }
		{ "description": "S", "filter": "s" }
		{ "description": "T", "filter": "t" }
		{ "description": "U", "filter": "u" }
		{ "description": "V", "filter": "v" }
		{ "description": "W", "filter": "w" }
		{ "description": "X", "filter": "x" }
		{ "description": "Y", "filter": "y" }
		{ "description": "Z", "filter": "z" }
	]

module.exports = BrowseRouter