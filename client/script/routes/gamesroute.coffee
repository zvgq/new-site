define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			model: (params)->
				if params.filter
					this.store.find 'game', { "filter": params.filter }
				else
					this.store.find 'game', { "filter": "new" }
		
		return route