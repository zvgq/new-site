(function() {
  define(["ember"], function(Ember) {
    var route;
    route = Ember.Route.extend({
      model: function() {
        return this.store.find('game');
      }
    });
    return route;
  });

}).call(this);
