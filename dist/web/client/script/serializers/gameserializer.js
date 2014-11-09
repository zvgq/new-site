(function() {
  define(["ember-data"], function(DS) {
    var serializer;
    serializer = DS.RESTSerializer.extend(DS.EmbeddedRecordsMixin, {
      attrs: {
        quotes: {
          embedded: 'always'
        }
      }
    });
    return serializer;
  });

}).call(this);
