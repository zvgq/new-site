define [
	"jquery"
	"backbone"
], ($, Backbone)->
	class GameModel extends Backbone.Model
		defaults:
			title: "Game Name"
			platform: "Playstation 4"
			message: "Message Goes Here"
	
		# return		
		@