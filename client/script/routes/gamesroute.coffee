define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			model: (params)->
				this.store.find 'game', { "filter": params.filter }
					.then (filtered)->
						results = filtered
		
		return route