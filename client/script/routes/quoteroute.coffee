define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			model: (params)->
				return this.store.find 'quote', params.quote_id
		
		return route