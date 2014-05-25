define [
	"jquery"
	"backbone"
	"../collections/quotecollection"
	"../models/quotemodel"
	"../views/quotelistview"
	"../views/quoteview"
], ($, Backbone, QuoteCollection, QuoteModel, QuoteListView, QuoteView)->
	class GameView extends Backbone.View
		tagName: "div"
		
		initialize: ->
			
		render: ->
			htmlString = """
						<span>#{ @model.get 'title' }</span>
						<img alt='#{ @model.get 'title' }' src='#{ @model.get 'titleMedia' }' />
						"""
			$(@el).html htmlString
			
			@ #end render
			
		events:
			"click": "showQuotes"
			
		showQuotes: =>
			@quotes = new QuoteCollection [], { "gameId": @model.id }
			@quotesView = new QuoteListView { el: "#quotes .list", collection: @quotes }
			successCallback = (collection, response, options)->
				$("#quotes").modal('show')
			errorCallback = (collection, response, options)->
				console.log("Error occured")
			
			@quotes.fetch { "success": successCallback }
		
		@ #end class