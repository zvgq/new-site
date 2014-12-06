bodyParser 	= require "body-parser"
engines		= require "consolidate"
express 	= require "express"
fs			= require "fs"
http		= require "http"
https		= require "https"
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

apiRouter = new routers.ApiRouter()
app.use "/api", apiRouter.router

browseRouter = new routers.BrowseRouter()
app.use "/browse", browseRouter.router

app.use "/", (req, res)->
	res.redirect "/browse"

httpDefaultPort = nconf.get "HTTP_DEFAULT_PORT"

if app.get("env") is "development"
	httpServer = http.createServer app
	httpServer.listen
	console.log "ZVGQ - HTTP started on port " + httpDefaultPort

httpsDefaultPort = nconf.get "HTTPS_DEFAULT_PORT"
port = if process.env.PORT then process.env.PORT else httpsDefaultPort
httpsOptions = 
	key: fs.readFileSync "key.pem"
	cert: fs.readFileSync "cert.pem"
httpsServer = https.createServer httpsOptions, app
httpsServer.listen port
console.log "ZVGQ - HTTPS started on port " + port
