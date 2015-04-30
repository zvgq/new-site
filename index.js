/// <reference path="typings/tsd.d.ts" />

(function() {
	var bodyParser 	= require("body-parser");
	var engines		= require("consolidate");
	var express 	= require("express");
	var favicon		= require("serve-favicon");
	var http		= require("http");
	var nconf 		= require("nconf");
	var path		= require("path");
	
	var WWWRouter	= require("./routers/wwwrouter");
	
	var app
		, configFile
		, defaultPort
		, port
		, server;
		
	// middleware functions
	function useHTTPS(req, res, next) {
		var redirectUrl;
		if(!(req.get('x-arr-ssl')) && (req.get("x-site-deployment-id"))) {
			redirectUrl = "https://" + req.get("host") + req.url;
			return res.redirect(redirectUrl);
		}
		else {
			return next();
		}
	}
	
	// configure
	if(process.env.NODE_ENV === "development") {
		console.log("Setting up DEVELOPMENT environment...");
		configFile = "config.dev.json";
	}
	else {
		console.log("Setting up PRODUCTION environment...");
		configFile = "config.json";
	}
	
	// setup
	nconf.argv()
			.file(configFile)
			.env();
			
	defaultPort = nconf.get("DEFAULT_PORT");
	port = process.env.PORT ? process.env.PORT : defaultPort;
			
	// intialize
	app = express();
	app.set("view engine", "jade");
	app.set("views", path.join(__dirname, "/views"));
	app.engine("jade", engines.jade);
	app.use(bodyParser.json());
	app.use(bodyParser.urlencoded({
		extended: true
	}));
	app.use(express["static"](path.join(__dirname, "/client")));
	app.use(favicon(path.join(__dirname, "./client/images/favicon.ico")));
	app.use(useHTTPS);
	app.use("/", (new WWWRouter()).router);
	
	// start
	server = http.createServer(app);
	server.listen(port);
	console.log("ZVGQ -- Started on Port " + port);

}).call(this);