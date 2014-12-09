class Quote
	constructor: (sourceEntity)->
		@id				= sourceEntity.RowKey._ if sourceEntity.RowKey
		@gameId			= sourceEntity.gameId._ if sourceEntity.gameId
		@title			= sourceEntity.title._ if sourceEntity.title
		@mediaUri		= sourceEntity.mediaUri._ if sourceEntity.mediaUri
		@description 	= sourceEntity.description._ if sourceEntity.description

module.exports = Quote