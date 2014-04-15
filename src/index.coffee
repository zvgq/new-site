azure 		= require "azure"
bodyParser 	= require 'body-parser'
engines		= require "consolidate"
express 	= require "express"
nconf 		= require "nconf"

routers	= require "./routers"

# get configuration data
nconf.env().file({ file: 'config.json'});

gameTableName 	= nconf.get "GAME_TABLE_NAME"
partitionKey 	= nconf.get "PARTITION_KEY"
accountName 		= nconf.get "STORAGE_NAME"
accountKey 		= nconf.get "STORAGE_KEY"

# setup server
server = express()

server.set "view engine", "hbs"
server.set "views", "#{ __dirname }/views"
server.engine "hbs", engines.handlebars

server.use express.static(__dirname + '/public')
server.use bodyParser()

apiRouter = new routers.ApiRouter()
server.use "/api", apiRouter.router

browseRouter = new routers.BrowseRouter()
server.use "/browse", browseRouter.router

# redirect root to browse application
server.use "/", (req, res)->
	res.redirect "/browse"

server.listen 3000
console.log "Listening on port 3000"