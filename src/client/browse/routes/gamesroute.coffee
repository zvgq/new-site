define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			model: ()->
				return this.store.find 'game'
		
		return route