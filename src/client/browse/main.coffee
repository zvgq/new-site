require.config
	baseUrl: "/script"
	paths:
		"ember": "../bower_components/ember/ember"
		"ember-data": "../bower_components/ember-data/ember-data"
		"jquery": "../bower_components/jquery/dist/jquery.min"
		"handlebars": "../bower_components/handlebars/handlebars.min"
		"models": "./browse/models/index"
		"routes": "./browse/routes/index"

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
                
require ["ember", "models", "routes"], 
	(Ember, Models, Routes)->
		window.ZVGQBrowse = Ember.Application.create()
		
		Models.setup()
		Routes.setup()
		
		#ZVGQBrowse.ApplicationAdapter = DS.FixtureAdapter.extend();
		ZVGQBrowse.ApplicationAdapter = DS.RESTAdapter.extend
			namespace: "api"

		# configure router
		setupRoutes = ()->
			@route "games"
			@route "game", { path: '/game/:game_id' }

		ZVGQBrowse.Router.map setupRoutes
		ZVGQBrowse.Router.reopen { rootURL: '/browse/' }