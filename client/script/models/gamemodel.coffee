define ["ember", "ember-data"],
	(Ember, DS)->		
		model = DS.Model.extend
			description: DS.attr 'string'
			title: DS.attr 'string'
			titleMediaUri: DS.attr 'string'
			
			quotes: DS.hasMany 'quote'
			
			quoteCount: Ember.computed(->
				quotes = @get "quotes"  
				quotes.get "length" 
			).property("quotes.@each")
					
		return model
			