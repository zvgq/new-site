(function() {
  define(["ember", "ember-data"], function(Ember, DS) {
    var model;
    model = DS.Model.extend({
      description: DS.attr('string'),
      title: DS.attr('string'),
      titleMediaUri: DS.attr('string'),
      quotes: DS.hasMany('quote'),
      quoteCount: Ember.computed(function() {
        var quotes;
        quotes = this.get("quotes");
        return quotes.get("length");
      }).property("quotes.@each")
    });
    return model;
  });

}).call(this);
