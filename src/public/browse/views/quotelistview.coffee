define [
	"jquery"
	"backbone"
	"../models/quotemodel"
	"../collections/quotecollection"
	"../views/quoteview"
], ($, Backbone, QuoteModel, QuoteCollection, QuoteView)->
	class QuoteListView extends Backbone.View	
		initialize: ->
			@render()
			
			@collection.bind "add", @appendItem
			
		render: ->
			$(@el).html ""
		
		appendItem: (item)=>
			quoteView = new QuoteView model: item
			$(@el).append quoteView.render().el