define ["ember"],(Ember)->
	setup: (App)->
		route = 
			model: ()->
				games = [
					{ "title": "Shadowgate", "titleMediaUri": "/content/default-title.png" }
					{ "title": "Shadowgate (2014)", "titleMediaUri": "/content/default-title.png" }
				]
				return games
		App.GamesRoute = Ember.Route.extend(route)