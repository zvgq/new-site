class Game
	constructor: (sourceEntity)->
		mediaLocation	= require('nconf').get "MEDIA_LOCATION"
		
		@id 			= sourceEntity.RowKey._ if sourceEntity.RowKey
		@description	= sourceEntity.description._ if sourceEntity.description
		@title 			= sourceEntity.title._ if sourceEntity.title
		@titleMediaUri 	= "#{ mediaLocation}#{sourceEntity.titleMediaUri._}" if sourceEntity.titleMediaUri
		
		# collection proprties
		@quotes = null

module.exports = Game