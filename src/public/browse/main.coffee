requirejs.config
	baseUrl: "/script"
	shim:
		"underscore":
			"exports": "_"
		"backbone":
			"deps": [
				"underscore"
				"jquery"
			]
			"exports":
				"Backbone"
	paths:
		"jquery": "../bower_components/jquery/dist/jquery"
		"underscore": "../bower_components/underscore/underscore"
		"backbone": "../bower_components/backbone/backbone"

require [
	"jquery"
	"backbone"
	"./browse/views/gamelistview"
	"./browse/collections/gamecollection"
], ($, Backbone, GameListView, GameCollection)->

	class BrowseAppView extends Backbone.View
		el: $ "body"
		
		events:
			"click .filter": "addAll"
		
		initialize: ->
			@counter = 1000
		
			@games = new GameCollection
			@gamesView = new GameListView { el: "#games", collection: @games }
			
			@games.fetch()
			
		addAll: (event)->
			@games.fetch({ data: $(event.currentTarget).data()})
		
	appview = new BrowseAppView()
