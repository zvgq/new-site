define ["ember-data"],
	(DS)->		
		model = DS.Model.extend
			description: DS.attr 'string'
			mediaUri: DS.attr 'string'
			title: DS.attr 'string'
			
			game: DS.belongsTo 'game'
			
		return model