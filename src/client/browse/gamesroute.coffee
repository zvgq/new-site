define ["ember"],(Ember)->
	setup: (App)->
		route = 
			model: ()->
				model = {}
				
				# TODO: Load content dynamically from storage
				model.games = [
					{ "id": "shadowgate", "title": "Shadowgate", "titleMediaUri": "/content/default-title.png", "description": "Shadowgate on the NES" }
					{ "id": "shadowgate-2014", "title": "Shadowgate (2014)", "titleMediaUri": "/content/default-title.png", "description": "Shadowgate on the PC by Zojoi" }
				]
				return model

		App.GamesRoute = Ember.Route.extend(route)