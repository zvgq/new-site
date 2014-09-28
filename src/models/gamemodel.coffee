QuotesRepository = require '../repositories/quotesrepository'

class Game
	constructor: (sourceEntity)->
		@id 			= sourceEntity.RowKey._ if sourceEntity.RowKey
		@description	= sourceEntity.description._ if sourceEntity.description
		@title 			= sourceEntity.title._ if sourceEntity.title
		@titleMediaUri 	= sourceEntity.titleMediaUri._ if sourceEntity.titleMediaUri
		
		# collection proprties
		@quotes = null

module.exports = Game