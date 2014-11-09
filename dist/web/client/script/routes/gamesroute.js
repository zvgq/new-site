(function() {
  define(["ember"], function(Ember) {
    var route;
    route = Ember.Route.extend({
      model: function(params) {
        return this.store.find('game', {
          "filter": params.filter
        }).then(function(filtered) {
          var results;
          return results = filtered;
        });
      }
    });
    return route;
  });

}).call(this);
