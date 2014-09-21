class Game
	constructor: (sourceEntity)->
		@id 			= sourceEntity.RowKey._
		@description	= sourceEntity.Description._
		@title 			= sourceEntity.Title._
		@titleMediaUri 	= sourceEntity.TitleMediaUri._

module.exports = Game