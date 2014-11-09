(function() {
  define(["ember"], function(Ember) {
    var route;
    route = Ember.Route.extend({
      model: function(params) {
        return this.store.find('game', params.game_id);
      }
    });
    return route;
  });

}).call(this);
