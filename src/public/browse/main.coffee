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
		"bootstrap":
			"deps": [
				"jquery"
			]
			"exports":
				"Bootstrap"
	paths:
		"jquery": "../bower_components/jquery/dist/jquery"
		"underscore": "../bower_components/underscore/underscore"
		"backbone": "../bower_components/backbone/backbone"
		"bootstrap": "../bower_components/bootstrap/dist/js/bootstrap.min.js"

require [
	"jquery"
	"backbone"
	"bootstrap"
	"./browse/views/gamelistview"
	"./browse/collections/gamecollection"
], ($, Backbone, Bootstrap, GameListView, GameCollection)->

	class BrowseAppView extends Backbone.View
		el: $ "body"
		
		events:
			"click .filter": "addAll"
		
		initialize: ->	
			@games = new GameCollection
			@gamesView = new GameListView { el: "#games", collection: @games }
			
			@games.fetch()
			
		addAll: (event)->
			@games.fetch({ data: $(event.currentTarget).data()})
		
	appview = new BrowseAppView()
