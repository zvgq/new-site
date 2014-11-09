define ["serializers/gameserializer"],
	(GameSerializer)->
		setup: ()->
			ZVGQBrowse.GameSerializer = GameSerializer