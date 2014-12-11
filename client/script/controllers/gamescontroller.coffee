define ["ember"],
	(Ember)->
		controller = Ember.ArrayController.extend
			itemController: 'game'
		
		return controller