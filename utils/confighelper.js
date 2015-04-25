"use strict";

var nconf = require("nconf");

var ConfigHelper = {};
ConfigHelper.getMediaLocation = function() {
	var key = "MEDIA_LOCATION";
	var retrieved,
		result;

	retrieved = nconf.get(key);
	result = retrieved ? retrieved : null;

	return result;
}

module.exports = ConfigHelper;
