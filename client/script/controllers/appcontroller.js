(function() {
  define(["ember", "text!data/queries.json"], function(Ember, queryArray) {
    var controller;
    controller = Ember.Controller.extend({
      queries: JSON.parse(queryArray)
    });
    return controller;
  });

}).call(this);
