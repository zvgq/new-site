class Game
	constructor: (sourceEntity)->
		@id 		= sourceEntity.RowKey._
		@title 		= sourceEntity.Name._
		@titleMedia = sourceEntity.TitleMedia._

module.exports = Game