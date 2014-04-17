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

require ["backbone"], (Backbone)->
	