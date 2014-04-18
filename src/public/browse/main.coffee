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

require ["jquery", "backbone"], ($, Backbone)->
	class GameListView extends Backbone.View
		el: "#main"
		
		initialize: ()->
			this.render()
			
		render: ()->
			$(@el).html "<h1>Hello World</h1>"
			
	gameList = new GameListView()
