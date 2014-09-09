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

module.exports = BrowseRouter