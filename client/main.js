(function() {
  require.config({
    baseUrl: "/",
    paths: {
      "ember": "lib/ember/ember",
      "ember-data": "lib/ember-data/ember-data",
      "jquery": "lib/jquery/dist/jquery.min",
      "handlebars": "lib/handlebars/handlebars.min",
      "models": "script/models",
      "routes": "script/routes"
    },
    shim: {
      "bootstrap": {
        deps: "jquery",
        exports: "Bootstrap"
      },
      "ember": {
        deps: ["jquery", "handlebars"],
        exports: "Ember"
      },
      "ember-data": {
        deps: ["ember"],
        exports: "DS"
      }
    }
  });

  require(["ember", "models/index", "routes/index"], function(Ember, Models, Routes) {
    var setupRoutes;
    window.ZVGQBrowse = Ember.Application.create();
    Models.setup();
    Routes.setup();
    ZVGQBrowse.ApplicationAdapter = DS.RESTAdapter.extend({
      namespace: "api"
    });
    setupRoutes = function() {
      this.route("games");
      return this.route("game", {
        path: '/game/:game_id'
      });
    };
    ZVGQBrowse.Router.map(setupRoutes);
    return ZVGQBrowse.Router.reopen({
      rootURL: '/browse/'
    });
  });

}).call(this);
