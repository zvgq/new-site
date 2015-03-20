"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");

var GameModel		= require("../models/GameModel.js");

describe("GameModel", function() {
	describe("#createModelFromAzureEntry(entry)", function() {
		var testEntry =
			{
				RowKey: { _ : "rowkey"}
				, description: { _ : "description" }
				, title: { _ : "title" }
				, titleMediaUri: { _ : "titlemediauri" }
			};

		it("copies RowKey into the id field", function() {
			var result = GameModel.createModelFromAzureEntry(testEntry);
			expect(result.id).to.equal(testEntry.RowKey._);
		});

		it("copies description into the description field", function() {
			var result = GameModel.createModelFromAzureEntry(testEntry);
			expect(result.description).to.equal(testEntry.description._);
		});

		it("copies title into the title field", function() {
			var result = GameModel.createModelFromAzureEntry(testEntry);
			expect(result.title).to.equal(testEntry.title._);
		});

		it("copies titleMediaUri into the titleMediaUri field", function() {
			var result = GameModel.createModelFromAzureEntry(testEntry);
			expect(result.titleMediaUri).to.equal(testEntry.titleMediaUri._);
		});
	});
});
