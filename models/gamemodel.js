function GameModel() {
    this.id = undefined;
    this.description = undefined;
    this.title = undefined;
    this.titleMediaUri = undefined;
}

GameModel.createModelFromAzureEntry = function(entry) {
    model = new GameModel();

    model.id = entry.RowKey ? entry.RowKey._ : undefined;
    model.description = entry.description._ ? entry.description._ : undefined;
    model.title = entry.title._ ? entry.title._ : undefined;
    model.titleMediaUri = entry.titleMediaUri._ ? entry.titleMediaUri._ : undefined;

    return model;
}

module.exports = GameModel;
