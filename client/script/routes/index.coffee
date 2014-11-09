define ["routes/gamesroute", "routes/indexroute"],
	(GamesRoute, IndexRoute)->
		setup: ()->
			ZVGQBrowse.GamesRoute = GamesRoute
			ZVGQBrowse.IndexRoute = IndexRoute