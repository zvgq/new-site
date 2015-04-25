"use strict";

var url             = require("url");

var ConfigHelper    = require("../utils/confighelper.js");

function QuoteModel() {
    this.id = undefined;
    this.gameId = undefined;
    this.title = undefined;
    this.description = undefined;
    this.titleMediaUri = undefined;
    this.mediaUri = undefined;
}

QuoteModel.createModelFromAzureEntry = function(entry) {
    var converted = null;

    if(entry.PartitionKey._ === "zvgq-quote" && entry.RowKey && entry.gameId) {
        converted = new QuoteModel();

        converted.id = entry.RowKey._;
        converted.gameId = entry.gameId._;
        converted.title = entry.title ? entry.title._ : null;
        converted.description = entry.description ? entry.description._ : null;
        converted.titleMediaUri = entry.titleMediaUri ? url.resolve(ConfigHelper.getMediaLocation(), entry.titleMediaUri._) : null;
        converted.mediaUri = entry.mediaUri ? url.resolve(ConfigHelper.getMediaLocation(), entry.mediaUri._) : null;
    }

    return converted;
}

module.exports = QuoteModel;
