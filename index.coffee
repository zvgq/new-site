bodyParser 	= require "body-parser"
engines		= require "consolidate"
express 	= require "express"
nconf 		= require "nconf"
path		= require "path"

routers		= require "./routers"

# get configuration data
nconf.env().file({ file: 'config.json'});
nconf.load()

# setup server
server = express()

server.set "view engine", "jade"
server.set "views", "#{ __dirname }/views"
server.engine "jade", engines.jade

server.use bodyParser.json()
server.use bodyParser.urlencoded({ extended: true })

server.use(express.static(path.join(__dirname, "/client")))

apiRouter = new routers.ApiRouter()
server.use "/api", apiRouter.router

browseRouter = new routers.BrowseRouter()
server.use "/browse", browseRouter.router

server.use "/", (req, res)->
	res.redirect "/browse"
  
port = if process.env.PORT then process.env.PORT else 3000
server.listen port
console.log "ZVGQ started on port " + port