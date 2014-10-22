require.config
	baseUrl: "/"
	paths:
		"ember": "lib/ember/ember"
		"ember-data": "lib/ember-data/ember-data"
		"jquery": "lib/jquery/dist/jquery.min"
		"handlebars": "lib/handlebars/handlebars.min"
		"models": "script/models"
		"routes": "script/routes"
		"serializers": "script/serializers"

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
                
require ["ember", "models/index", "routes/index", "serializers/index"], 
	(Ember, Models, Routes, Serializers)->
		window.ZVGQBrowse = Ember.Application.create()
		
		Models.setup()
		Routes.setup()
		Serializers.setup()
		
		#ZVGQBrowse.ApplicationAdapter = DS.FixtureAdapter.extend();
		ZVGQBrowse.ApplicationAdapter = DS.RESTAdapter.extend
			namespace: "api"

		# configure router
		setupRoutes = ()->
			@route "games"
			@route "game", { path: '/game/:game_id' }

		ZVGQBrowse.Router.map setupRoutes
		ZVGQBrowse.Router.reopen { rootURL: '/browse/' }