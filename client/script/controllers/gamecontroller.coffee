define ["ember"],
	(Ember)->
		controller = Ember.ObjectController.extend
			queryParams: ['filter']
					
			tileStyle: (()->
				styleValue = ""
				uri = @get 'titleMediaUri'
				if uri
					styleValue = "background-image: url(#{ uri })"
				else
					styleValue = "background-color: #0000ff"
					
				return styleValue
			).property('model.tileStyle')
		
		return controller