azure = require "azure-storage"

GameModel = require "../models/gamemodel"

class GamesRepository
	# constructor
	constructor: (tableName, accountName, accountKey)->
        @tableName = tableName
        
        @tableService = azure.createTableService accountName, accountKey
        @tableService.createTableIfNotExists @tableName, (error, result, response)->
            if error
                console.log "Error createIfNotExists 'games' table in GamesRepository"

	# Static Methods
	list: (req, res)=>
        query = null

        if req.params.letter
            letter = req.params.letter
            nextLetter = String.fromCharCode(letter.charCodeAt(0) + 1)

            query = new azure.TableQuery
                        .top(10)
                        .where 'RowKey ge ?', letter
                        .and 'RowKey lt ?', nextLetter
        else
            query = new azure.TableQuery()
                        .select ["RowKey", "Name", "Description", "TitleMedia"]
                        .top 10
                    
        @tableService.queryEntities @tableName, query, null, (error, result)->
            if error
                console.log "Error occurred with code #{ error.code } and statusCode #{ error.statusCode }"
                res.status 500
                    .end()
            else
                # TODO: Return result.entries as formatted objects
                results = 
                    new GameModel entry for entry in result.entries
                res.status 200
                    .end()

	get: (req, res)=>
		rowKey = req.params.title

		@storageClient.queryEntity @tableName, @partitionKey, rowKey, (error, entity)->
			if not error
				result = new GameModel entity
				res.json 200, result
			else
				console.log "Error occurred with code #{ error.code } and statusCode #{ error.statusCode }"
				res.send 500

module.exports = GamesRepository
