define ["./browse/routes/gamesroute", "./browse/routes/indexroute"],
	(GamesRoute, IndexRoute)->
		setup: ()->
			ZVGQBrowse.GamesRoute = GamesRoute
			ZVGQBrowse.IndexRoute = IndexRoute