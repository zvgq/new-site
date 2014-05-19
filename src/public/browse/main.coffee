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
], ($, Backbone, GameListView)->

	class BrowseAppView extends Backbone.View
		el: $ "body"
			
		initialize: ->
			@games = new GameListView { el: "#games"}
			
	appview = new BrowseAppView()
