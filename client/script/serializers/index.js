(function() {
  define(["serializers/gameserializer"], function(GameSerializer) {
    return {
      setup: function() {
        return ZVGQBrowse.GameSerializer = GameSerializer;
      }
    };
  });

}).call(this);
