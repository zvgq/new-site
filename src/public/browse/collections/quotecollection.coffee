define [
	"backbone"
	"../models/quotemodel"
], (Backbone, QuoteModel)->
	class QuoteCollection extends Backbone.Collection
		model: QuoteModel
		
		initialize: (models, options)->
			@options = options
			
		url: ()->
			"/api/quotes/#{ @options.gameId }"
		
		#returns
		@