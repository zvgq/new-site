"use strict";

var url             = require("url");

var ConfigHelper    = require("../utils/confighelper.js");

function GameModel() {
    this.id = undefined;
    this.description = undefined;
    this.title = undefined;
    this.titleMediaUri = undefined;

    this.quotes = undefined;
}

//
//  STATIC FUNCTIONS
//
GameModel.validateId = function(id) {
    var validIdRegex = /^([a-z0-9]+-?[a-z0-9]*)[^\s\0?!{}()<>,.:;'"!@#$%^&*()~`_=+\[\]|\\//]*$/g
        , result = false;

    if(id !== undefined) {
        result = validIdRegex.test(id);
    }

    return result;
}

GameModel.createModelFromAzureEntry = function(entry) {
    var model = new GameModel();

    model.id = entry.RowKey ? entry.RowKey._ : undefined;
    model.description = entry.description._ ? entry.description._ : undefined;
    model.title = entry.title._ ? entry.title._ : undefined;
    model.titleMediaUri = entry.titleMediaUri._ ? url.resolve(ConfigHelper.getMediaLocation(), entry.titleMediaUri._) : undefined;

    return model;
}

module.exports = GameModel;
