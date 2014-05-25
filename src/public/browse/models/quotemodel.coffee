define [
	"backbone"
], (Backbone)->
	class QuoteModel extends Backbone.Model
		defaults:
			id: "Id"
			gameId: "GameId"
			text: "Title"
			mediaUrl: "TitleMedia"
	
		# return		
		@