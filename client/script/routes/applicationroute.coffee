define ["ember", "jquery"],
	(Ember, $)->
		route = Ember.Route.extend
			actions:
				loading: (transition, originRoute)->
					$("#loadingDisplay").show()
					return true
				
				didTransition: ()->
					$("#loadingDisplay").hide()
		
		return route