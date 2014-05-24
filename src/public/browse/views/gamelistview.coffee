define [
	"jquery"
	"backbone"
	"../models/gamemodel"
	"../collections/gamecollection"
	"../views/gameview"
], ($, Backbone, GameModel, GameCollection, GameView)->
	class GameListView extends Backbone.View	
		initialize: ->
			@counter = 0
			@render()
			
			@collection.bind "add", @appendItem
			
		render: ->
			# nothing
		
		appendItem: (item)=>
			gameView = new GameView model: item
			$(@el).append gameView.render().el