class Quote
	constructor: (sourceEntity)->
		@id				= sourceEntity.RowKey._ if sourceEntity.RowKey
		@gameId			= sourceEntity.gameId._ if sourceEntity.gameId
		@shortName		= sourceEntity.shortName._ if sourceEntity.shortName
		@text 			= sourceEntity.text._ if sourceEntity.text
		@mediaUri		= sourceEntity.mediaUri._ if sourceEntity.mediaUri
		@description 	= sourceEntity.description._ if sourceEntity.description

module.exports = Quote