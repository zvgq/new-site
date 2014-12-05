define ["routes/applicationroute", "routes/gamesroute", "routes/gamesdefaultroute", "routes/quoteroute", "routes/indexroute"],
	(ApplicationRoute, GamesRoute, GamesDefaultRoute, QuoteRoute, IndexRoute)->
		setup: ()->
			ZVGQBrowse.ApplicationRoute = ApplicationRoute
			ZVGQBrowse.GamesRoute = GamesRoute
			ZVGQBrowse.GamesDefaultRoute = GamesDefaultRoute
			ZVGQBrowse.QuoteRoute = QuoteRoute
			ZVGQBrowse.IndexRoute = IndexRoute