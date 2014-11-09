(function() {
  define(["ember-data", "models/gamemodel", "models/quotemodel"], function(DS, GameModel, QuoteModel) {
    return {
      setup: function() {
        ZVGQBrowse.Game = GameModel;
        ZVGQBrowse.Quote = QuoteModel;
        return ZVGQBrowse.Game.FIXTURES = [
          {
            "id": "shadowgate",
            "title": "Shadowgate",
            "titleMediaUri": "/content/default-title.png",
            "description": "Shadowgate on the NES"
          }, {
            "id": "shadowgate-2014",
            "title": "Shadowgate (2014)",
            "titleMediaUri": "/content/default-title.png",
            "description": "Shadowgate on the PC by Zojoi"
          }
        ];
      }
    };
  });

}).call(this);
