class Game
	constructor: (sourceEntity)->
		@id 			= sourceEntity.RowKey._ if sourceEntity.RowKey
		@description	= sourceEntity.Description._ if sourceEntity.Description
		@title 			= sourceEntity.Title._ if sourceEntity.Title
		@titleMediaUri 	= sourceEntity.TitleMediaUri._ if sourceEntity.TitleMediaUri

module.exports = Game