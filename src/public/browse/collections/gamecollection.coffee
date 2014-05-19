define [
	"backbone"
	"../models/gamemodel"
], (Backbone, GameModel)->
	class GameCollection extends Backbone.Collection
		model: GameModel
		
		#returns
		@