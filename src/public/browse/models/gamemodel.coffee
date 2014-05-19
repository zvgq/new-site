define [
	"jquery"
	"backbone"
], ($, Backbone)->
	class GameModel extends Backbone.Model
		defaults:
			id: 0
			title: "Title"
			titleMedia: "TitleMedia"
	
		# return		
		@