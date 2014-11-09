(function() {
  define(["ember-data"], function(DS) {
    var model;
    model = DS.Model.extend({
      description: DS.attr('string'),
      mediaUri: DS.attr('string'),
      text: DS.attr('string'),
      game: DS.belongsTo('game')
    });
    return model;
  });

}).call(this);
