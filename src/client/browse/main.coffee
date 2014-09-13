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
                
require ["ember"], 
	(Ember)->
		@App = Ember.Application.create()
		
		route = 
			model: ()->
				games = [
					{ "title": "Shadowgate", "titleMediaUri": "/content/default-title.png" }
					{ "title": "Shadowgate (2014)", "titleMediaUri": "/content/default-title.png" }
				]
				return games
		@App.GamesRoute = Ember.Route.extend(route)

		setupRoutes = ()->
			@route "games"

		@App.Router.map setupRoutes
		@App.Router.reopen { rootURL: '/browse/' }