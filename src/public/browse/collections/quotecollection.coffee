define [
	"backbone"
	"../models/quotemodel"
], (Backbone, QuoteModel)->
	class QuoteCollection extends Backbone.Collection
		model: QuoteModel
		url: "/api/quotes/a-boy-and-his-blob"
		
		#returns
		@