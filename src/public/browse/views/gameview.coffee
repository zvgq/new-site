define ["backbone"], (Backbone)->
	class GameView extends Backbone.View
		tagName: "li"
		
		initialize: ->
			# nothing
			
		render: ->
			$(@el).html "<span>#{@model.get 'title'} Message: #{@model.get 'message'}</span>"
			
			#return
			@
			
		#return
		@