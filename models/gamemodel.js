var nconf =     require("nconf");

function GameModel() {
    this.id = undefined;
    this.description = undefined;
    this.title = undefined;
    this.titleMediaUri = undefined;
}

GameModel.getMediaLocation = function() {
    return nconf.get("MEDIA_LOCATION");
}

GameModel.validateId = function(id) {
    var validIdRegex = /^([a-z0-9]+-?[a-z0-9]*)[^\s\0?!{}()<>,.:;'"!@#$%^&*()~`_=+\[\]|\\//]*$/g
        , result = false;

    if(id !== undefined) {
        result = validIdRegex.test(id);
    }

    return result;
}

GameModel.createModelFromAzureEntry = function(entry) {
    model = new GameModel();

    model.id = entry.RowKey ? entry.RowKey._ : undefined;
    model.description = entry.description._ ? entry.description._ : undefined;
    model.title = entry.title._ ? entry.title._ : undefined;
    model.titleMediaUri = entry.titleMediaUri._ ? GameModel.getMediaLocation().concat(entry.titleMediaUri._) : undefined;

    return model;
}

module.exports = GameModel;
