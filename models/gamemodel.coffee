class Game
	constructor: (sourceEntity)->
		mediaLocation	= require('nconf').get "MEDIA_LOCATION"
		
		@id 			= if sourceEntity.RowKey._ is undefined then sourceEntity.RowKey else sourceEntity.RowKey._
		@description	= if sourceEntity.description._ is undefined then sourceEntity.description else sourceEntity.description._
		@title 			= if sourceEntity.title._ is undefined then sourceEntity.title else sourceEntity.title._
		@titleMediaUri 	= if sourceEntity.titleMediaUri._ is undefined then "#{ mediaLocation}#{sourceEntity.titleMediaUri}" else sourceEntity.titleMediaUri._
		
		# collection proprties
		@quotes = null

module.exports = Game