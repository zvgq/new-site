define ["controllers/appcontroller", "controllers/gamecontroller", "controllers/gamescontroller"],
	(ApplicationController, GameController, GamesController)->
		setup: ()->
			ZVGQBrowse.ApplicationController = ApplicationController
			ZVGQBrowse.GameController = GameController
			ZVGQBrowse.GamesController = GamesController