define [
	"jquery"
	"backbone"
	"../collections/quotecollection"
	"../views/quotelistview"
	"../views/quoteview"
], ($, Backbone, QuoteCollection, QuoteListView, QuoteView)->
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
			@quotes = new QuoteCollection
			@quotesView = new QuoteListView { el: "#quotes .list", collection: @quotes }
			successCallback = (collection, response, options)->
				$("#quotes").modal('show')
			
			@quotes.fetch { "success": successCallback }
		
		@ #end class