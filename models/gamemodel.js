(function() {
  var Game;

  Game = (function() {
    function Game(sourceEntity) {
      if (sourceEntity.RowKey) {
        this.id = sourceEntity.RowKey._;
      }
      if (sourceEntity.description) {
        this.description = sourceEntity.description._;
      }
      if (sourceEntity.title) {
        this.title = sourceEntity.title._;
      }
      if (sourceEntity.titleMediaUri) {
        this.titleMediaUri = sourceEntity.titleMediaUri._;
      }
      this.quotes = null;
    }

    return Game;

  })();

  module.exports = Game;

}).call(this);
