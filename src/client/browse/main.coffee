requirejs.config
	baseUrl: "/script"
	shim:
		"bootstrap":
			"deps": [
				"jquery"
			]
			"exports":
				"Bootstrap"
		"ember":
			"deps": [
				"handlebars"
			]
	paths:
		"bootstrap": "../bower_components/bootstrap/dist/js/bootstrap.min"
		"ember": "../bower_components/ember/ember"
		"handlebars": "./handlebars-1.1.2"
		"jquery": "../bower_components/jquery/dist/jquery"
		
require [
	"jquery"
	"bootstrap"
	"ember"
], 
($, Bootstrap)->
	@App = Ember.Application.create()

	#Setup Routes
	mapRoutes = ()->
		@route "games"
	
	@App.Router.map mapRoutes