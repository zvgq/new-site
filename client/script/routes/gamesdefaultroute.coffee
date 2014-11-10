define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			beforeModel: ()->
				this.transitionTo "games", "new"
		
		return route