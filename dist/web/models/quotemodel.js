(function() {
  var Quote;

  Quote = (function() {
    function Quote(sourceEntity) {
      if (sourceEntity.RowKey) {
        this.id = sourceEntity.RowKey._;
      }
      if (sourceEntity.gameId) {
        this.gameId = sourceEntity.gameId._;
      }
      if (sourceEntity.shortName) {
        this.shortName = sourceEntity.shortName._;
      }
      if (sourceEntity.text) {
        this.text = sourceEntity.text._;
      }
      if (sourceEntity.mediaUri) {
        this.mediaUri = sourceEntity.mediaUri._;
      }
      if (sourceEntity.description) {
        this.description = sourceEntity.description._;
      }
    }

    return Quote;

  })();

  module.exports = Quote;

}).call(this);
