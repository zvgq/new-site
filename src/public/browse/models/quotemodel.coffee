define [
	"backbone"
], (Backbone)->
	class QuoteModel extends Backbone.Model
		defaults:
			id: 0
			gameId: "GameId"
			text: "Title"
			mediaUrl: "TitleMedia"
	
		# return		
		@