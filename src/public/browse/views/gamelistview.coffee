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
			
			@collection = new GameCollection
			@collection.bind "add", @appendItem
			
		render: ->
			$(@el).append "<button>Add New Item</button>"
			$(@el).append "<ul><li>Hello World</li></ul>"
			
		addItem: ->
			@counter++
			
			item = new GameModel
			item.set message: "#{item.get 'title'} #{@counter}"
			
			@collection.add item
		
		appendItem: (item)->
			gameView = new GameView model: item
			$("ul").append gameView.render().el
		
		events:
			"click button": "addItem"