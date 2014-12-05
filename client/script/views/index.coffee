define ["views/gamesview", "views/gameview"],
	(GamesView, GameView)->
		setup: ()->
			ZVGQBrowse.GamesView = GamesView
			ZVGQBrowse.GameView = GameView