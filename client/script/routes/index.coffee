define ["routes/gamesroute", "routes/gamesdefaultroute", "routes/indexroute"],
	(GamesRoute, GamesDefaultRoute, IndexRoute)->
		setup: ()->
			ZVGQBrowse.GamesRoute = GamesRoute
			ZVGQBrowse.GamesDefaultRoute = GamesDefaultRoute
			ZVGQBrowse.IndexRoute = IndexRoute