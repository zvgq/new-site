class Game
	constructor: (sourceEntity)->
		@id 		= sourceEntity.RowKey
		@title 		= sourceEntity.Name
		@titleMedia = sourceEntity.TitleMedia

module.exports = Game