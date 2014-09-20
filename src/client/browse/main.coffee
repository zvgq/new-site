require.config
    baseUrl: "/script"
    paths:
        "ember": "../bower_components/ember/ember.prod"
        "jquery": "../bower_components/jquery/dist/jquery.min"
        "handlebars": "../bower_components/handlebars/handlebars.min"

    shim:
        "bootstrap":
            deps: "jquery"
            exports: "Bootstrap"
        "ember":
            deps: ["jquery", "handlebars"]
            exports: "Ember"
                
require ["ember", "./browse/gamesroute"], 
	(Ember, GamesRoute)->
		@App = Ember.Application.create()

		GamesRoute.setup(@App)
		setupRoutes = ()->
			@route "games"
			@route "game", { path: '/game/:game_id' }

		@App.Router.map setupRoutes
		@App.Router.reopen { rootURL: '/browse/' }