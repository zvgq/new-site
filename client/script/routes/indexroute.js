(function() {
  define(["ember"], function(Ember) {
    var route;
    route = Ember.Route.extend({
      beforeModel: function() {
        return this.transitionTo('games');
      }
    });
    return route;
  });

}).call(this);
