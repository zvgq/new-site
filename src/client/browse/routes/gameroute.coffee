define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			model: (params)->
				return this.store.find 'game', params.game_id
		
		return route