bodyParser 	= require "body-parser"
fs			= require "fs"
engines		= require "consolidate"
express 	= require "express"
http		= require "http"
nconf 		= require "nconf"
path		= require "path"

WWWRouter	= require "./routers/wwwrouter"

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

pkgJson = JSON.parse(fs.readFileSync("./package.json"))
app.locals.version = pkgJson.version;

useHTTPS = (req, res, next)->
	if not (req.get 'x-arr-ssl') and (req.get 'x-site-deployment-id')
		redirectUrl = "https://" + req.get("host") + req.url
		res.redirect redirectUrl
	else
		next()
app.use useHTTPS

app.use "/", (new WWWRouter()).router

defaultPort = nconf.get "DEFAULT_PORT"
port = if process.env.PORT then process.env.PORT else defaultPort

httpServer = http.createServer app
httpServer.listen port
console.log "ZVGQ - Started on port " + port
