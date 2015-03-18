require.config
	baseUrl: "/lib"
	paths:
		"bootstrap": "bootstrap/js"
		"ember": "ember/ember"
		"ember-data": "ember-data/ember-data"
		"jquery": "jquery/dist/jquery.min"
		"handlebars": "handlebars/handlebars.min"
		"masonry": "masonry/masonry"
		"text": "requirejs-text/text"
		"data": "../data"
		"models": "../script/models"
		"routes": "../script/routes"
		"serializers": "../script/serializers"
		"controllers": "../script/controllers"
		"views": "../script/views"
		"utils": "../script/utils"

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

require [
	"ember"
	, "masonry"
	, "models/index"
	, "routes/index"
	, "serializers/index"
	, "controllers/index"
	, "views/index"
], (Ember, Masonry, Models, Routes, Serializers, Controllers, Views)->
		window.ZVGQBrowse = Ember.Application.create()

		Models.setup()
		Routes.setup()
		Serializers.setup()
		Controllers.setup()
		Views.setup()

		#ZVGQBrowse.ApplicationAdapter = DS.FixtureAdapter.extend();
		ZVGQBrowse.ApplicationAdapter = DS.RESTAdapter.extend
			namespace: "api"

		# configure router
		setupRoutes = ()->
			@route "games_default", { path: '/games' }
			@route "games", { path: '/games/:filter' }
			@route "game", { path: '/game/:game_id' }, ()->
				@resource "quote", { path: '/quote/:quote_id' }

		ZVGQBrowse.Router.map setupRoutes
		ZVGQBrowse.Router.reopen { rootURL: '/browse/' }
