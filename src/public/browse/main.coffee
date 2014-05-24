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
		"semantic":
			"exports":
				"Semantic"
	paths:
		"jquery": "../bower_components/jquery/dist/jquery"
		"underscore": "../bower_components/underscore/underscore"
		"backbone": "../bower_components/backbone/backbone"
		"semantic": "../bower_components/semantic-ui/build/packaged/javascript/semantic"

require [
	"jquery"
	"backbone"
	"semantic"
	"./browse/views/gamelistview"
	"./browse/collections/gamecollection"
], ($, Backbone, Semantic, GameListView, GameCollection)->

	class BrowseAppView extends Backbone.View
		el: $ "body"
		
		events:
			"click .filter": "addAll"
		
		initialize: ->	
			@games = new GameCollection
			@gamesView = new GameListView { el: "#games", collection: @games }
			
			@games.fetch()
			
			$("#quotes").modal()
			
		addAll: (event)->
			@games.fetch({ data: $(event.currentTarget).data()})
		
	appview = new BrowseAppView()
