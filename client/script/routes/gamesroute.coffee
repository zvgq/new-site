define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			model: (params)->
				return this.store.find 'game', { "filter": params.filter }
		
		return route