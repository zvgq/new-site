"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var GameModel		= rewire("../models/gamemodel.js");

describe("GameModel", function() {
	// STUBS
	var testMediaLocation 	= "http://localhost:3000/test/media"
		, nconfGetStub		= sinon.stub();

	// TEST SETUP
	before(function() {
		nconfGetStub.withArgs("MEDIA_LOCATION").returns(testMediaLocation);
		GameModel.__set__({
			"nconf.get": nconfGetStub
		});
	});

	afterEach(function() {
		nconfGetStub.reset();
	});

	describe("#createModelFromAzureEntry(entry)", function() {
		var testEntry =
			{
				RowKey: { _ : "rowkey"}
				, description: { _ : "description" }
				, title: { _ : "title" }
				, titleMediaUri: { _ : "titlemediauri.png" }
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

		it("combines the media location and titleMediaUri into the titleMediaUri field", function() {
			var expected = testMediaLocation.concat(testEntry.titleMediaUri._)
				, result = GameModel.createModelFromAzureEntry(testEntry);

			expect(result.titleMediaUri).to.equal(expected);
		});
	});
});
