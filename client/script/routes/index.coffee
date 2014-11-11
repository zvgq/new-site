define ["routes/applicationroute", "routes/gamesroute", "routes/gamesdefaultroute", "routes/indexroute"],
	(ApplicationRoute, GamesRoute, GamesDefaultRoute, IndexRoute)->
		setup: ()->
			ZVGQBrowse.ApplicationRoute = ApplicationRoute
			ZVGQBrowse.GamesRoute = GamesRoute
			ZVGQBrowse.GamesDefaultRoute = GamesDefaultRoute
			ZVGQBrowse.IndexRoute = IndexRoute