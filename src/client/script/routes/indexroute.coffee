define ["ember"],
	(Ember)->
		route = Ember.Route.extend
			beforeModel: ()->
				this.transitionTo 'games'
		
		return route