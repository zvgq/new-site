define ["jquery", "backbone"], ($, Backbone)->
	class GameView extends Backbone.View
		tagName: "div"
		
		initialize: ->
			# nothing
			
		render: ->
			htmlString = """
						<span>#{ @model.get 'title' }</span>
						<img alt='#{ @model.get 'title' }' src='#{ @model.get 'titleMedia' }' />
						"""
			$(@el).html htmlString
			
			@ #end render
			
		events:
			"click": "showQuotes"
			
		showQuotes: ->
			$("#quotes").modal('show')
		
		@ #end class