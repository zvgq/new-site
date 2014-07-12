azure 		= require "azure"
bodyParser 	= require 'body-parser'
engines		= require "consolidate"
express 	= require "express"
nconf 		= require "nconf"
path		= require "path"

routers		= require "./routers"

# get configuration data
nconf.env().file({ file: 'config.json'});

gameTableName 	= nconf.get "GAME_TABLE_NAME"
partitionKey 	= nconf.get "PARTITION_KEY"
accountName 	= nconf.get "STORAGE_NAME"
accountKey 		= nconf.get "STORAGE_KEY"

# setup server
server = express()

server.set "view engine", "handlebars"
server.set "views", "#{ __dirname }/views"
server.engine "handlebars", engines.handlebars

server.use bodyParser.json()
server.use bodyParser.urlencoded({ extended: true })

server.use(express.static(path.join(__dirname, "/public")))

apiRouter = new routers.ApiRouter()
server.use "/api", apiRouter.router

browseRouter = new routers.BrowseRouter()
server.use "/browse", browseRouter.router

server.use "/", (req, res)->
	res.redirect "/browse"

	

server.listen 3000
console.log "Listening on port 3000"