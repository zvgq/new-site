express = require "express"
http	= require "http"	

class BrowseRouter
	constructor: ()->
		@router = express.Router()
		@router.get "/", (req, res, next)=>
			compare = (a, b)->
				if a.description < b.description
					return 1
				if a.description > b.description
					return -1
				return 0
			
			resultData = ''
			result = http.get "http://localhost:3000/api/games", (res)->
				console.log "Response received: #{ res.statusCode } for request #{ res.url }"
				body = ""

				res.on 'data', (chunk)->
					body += chunk

				res.on 'end', ()->
					resultData = JSON.parse body
		
			res.render "browse", { title: "Hello", body: "Hello again!", filters: @filters.sort(compare), results: resultData }
			
	filters: [
		{ "description": "#", "filter": "num" }
		{ "description": "A", "filter": "a" }
		{ "description": "B", "filter": "b" }
		{ "description": "C", "filter": "c" }
		{ "description": "D", "filter": "d" }
		{ "description": "E", "filter": "e" }
		{ "description": "F", "filter": "f" }
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