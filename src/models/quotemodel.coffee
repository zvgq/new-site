class Quote
	constructor: (sourceEntity)->
		@id 			= sourceEntity.RowKey
		@gameId		= sourceEntity.gameId
		@text 		= sourceEntity.text
		@mediaUrl 	= sourceEntity.mediaUrl

module.exports = Quote