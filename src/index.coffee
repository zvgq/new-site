azure 	= require "azure"
express = require "express"
nconf 	= require "nconf"

routers	= require "./routers"

# get configuration data
nconf.env().file({ file: 'config.json'});

gameTableName 	= nconf.get "GAME_TABLE_NAME"
partitionKey 	= nconf.get "PARTITION_KEY"
accountName 	= nconf.get "STORAGE_NAME"
accountKey 		= nconf.get "STORAGE_KEY"

# setup server
server = express()

apiRouter = new routers.ApiRouter()
server.use "/api", apiRouter.router

server.listen 3000