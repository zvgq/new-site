define ["ember", "text!data/queries.json"],
	(Ember, queryArray)->
		controller = Ember.Controller.extend
			queries: JSON.parse queryArray
			
		return controller