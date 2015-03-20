function Game() {
    this.id = undefined;
    this.description = undefined;
    this.title = undefined;
    this.titleMediaUri = undefined;
}

Game.createModelFromAzureEntry = function(entry) {
    model = new Game();

    model.id = entry.RowKey ? entry.RowKey._ : undefined;
    model.description = entry.description._ ? entry.description._ : undefined;
    model.title = entry.title._ ? entry.title._ : undefined;
    model.titleMediaUri = entry.titleMediaUri._ ? entry.titleMediaUri._ : undefined;

    return model;
}

module.exports = Game;
