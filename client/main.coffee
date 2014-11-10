require.config
	baseUrl: "/"
	paths:
		"ember": "lib/ember/ember"
		"ember-data": "lib/ember-data/ember-data"
		"jquery": "lib/jquery/dist/jquery.min"
		"handlebars": "lib/handlebars/handlebars.min"
		"text": "lib/requirejs-text/text"
		"data": "data"
		"models": "script/models"
		"routes": "script/routes"
		"serializers": "script/serializers"
		"controllers": "script/controllers"

	shim:
		"bootstrap":
			deps: "jquery"
			exports: "Bootstrap"
		"ember":
			deps: ["jquery", "handlebars"]
			exports: "Ember"
		"ember-data":
			deps: ["ember"]
			exports: "DS"
                
require ["ember", "models/index", "routes/index", "serializers/index", "controllers/index"], 
	(Ember, Models, Routes, Serializers, Controllers, queries)->
		window.ZVGQBrowse = Ember.Application.create()
		
		Models.setup()
		Routes.setup()
		Serializers.setup()
		Controllers.setup()
		
		#ZVGQBrowse.ApplicationAdapter = DS.FixtureAdapter.extend();
		ZVGQBrowse.ApplicationAdapter = DS.RESTAdapter.extend
			namespace: "api"

		# configure router
		setupRoutes = ()->
			@route "games_default", { path: '/games' }
			@route "games", { path: '/games/:filter' }
			@route "game", { path: '/game/:game_id' }

		ZVGQBrowse.Router.map setupRoutes
		ZVGQBrowse.Router.reopen { rootURL: '/browse/' }