(function() {
  define(["ember-data"], function(DS) {
    var model;
    model = DS.Model.extend({
      description: DS.attr('string'),
      title: DS.attr('string'),
      titleMediaUri: DS.attr('string')
    });
    return model;
  });

}).call(this);
