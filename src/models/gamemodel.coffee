class Game
	constructor: (sourceEntity)->
		@id 		= sourceEntity.RowKey
		@title 		= sourceEntity.title
		@titleMedia = sourceEntity.titleMedia

		@genres 	= JSON.parse(sourceEntity.genres) if sourceEntity.genres?
		@plaforms 	= JSON.parse(sourceEntity.platforms) if sourceEntity.platforms?

module.exports = Game