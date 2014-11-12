define ["ember", "utils/ui"],
	(Ember, UI)->
		view = Ember.View.extend
			scheduleMasonry: (()->
				Ember.run.scheduleOnce 'afterRender', this, UI.remason
			).observes 'controller.model'

			didInsertElement: ()->
				@scheduleMasonry();
					
		return view