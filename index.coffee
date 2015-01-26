bodyParser 	= require "body-parser"
engines		= require "consolidate"
express 	= require "express"
http		= require "http"
nconf 		= require "nconf"
path		= require "path"

routers		= require "./routers"

# get configuration data
nconf.env().file({ file: 'config.json'});
nconf.load()

# setup app
app = express()

app.set "view engine", "jade"
app.set "views", "#{ __dirname }/views"
app.engine "jade", engines.jade

app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: true })

app.use(express.static(path.join(__dirname, "/client")))

useHTTPS = (req, res, next)->
	if not (req.get 'x-arr-ssl') and (req.get 'x-site-deployment-id')
		redirectUrl = "https://" + req.get("host") + req.url
		res.redirect redirectUrl
	else
		next()
app.use useHTTPS

apiRouter = new routers.ApiRouter(app)
app.use "/api", apiRouter.router

browseRouter = new routers.BrowseRouter()
app.use "/browse", browseRouter.router

app.use "/", (req, res)->
	res.redirect "/browse"

defaultPort = nconf.get "DEFAULT_PORT"
port = if process.env.PORT then process.env.PORT else defaultPort

httpServer = http.createServer app
httpServer.listen port
console.log "ZVGQ - Started on port " + port
