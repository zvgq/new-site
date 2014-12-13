class Quote
	constructor: (sourceEntity)->
		mediaLocation	= require('nconf').get "MEDIA_LOCATION"
		
		@id				= sourceEntity.RowKey._ if sourceEntity.RowKey
		@gameId			= sourceEntity.gameId._ if sourceEntity.gameId
		@title			= sourceEntity.title._ if sourceEntity.title
		@mediaUri		= "#{ mediaLocation }#{ sourceEntity.mediaUri._ }" if sourceEntity.mediaUri._ 
		@description 	= sourceEntity.description._ if sourceEntity.description

module.exports = Quote