define ["ember-data"],
	(DS)->		
		model = DS.Model.extend
			description: DS.attr 'string'
			title: DS.attr 'string'
			titleMediaUri: DS.attr 'string'
			
			quotes: DS.hasMany 'quote'
			
		return model
			