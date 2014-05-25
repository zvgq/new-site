define [
	"jquery"
	"backbone"
], ($, Backbone)->
	class QuoteView extends Backbone.View
		tagName: "div"
		
		initialize: ->
			# nothing
			
		render: ->
			htmlString = """
						<span>#{ @model.get 'text' }</span>
						<img alt='#{ @model.get 'text' }' src='#{ @model.get 'mediaUrl' }' />
						"""
			$(@el).html htmlString
			
			@ #end render
			
		events:
			"click": "showMedia"
			
		showMedia: ->
			# Not Implemented
		
		@ #end class