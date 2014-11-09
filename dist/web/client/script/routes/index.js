(function() {
  define(["routes/gamesroute", "routes/indexroute"], function(GamesRoute, IndexRoute) {
    return {
      setup: function() {
        ZVGQBrowse.GamesRoute = GamesRoute;
        return ZVGQBrowse.IndexRoute = IndexRoute;
      }
    };
  });

}).call(this);
