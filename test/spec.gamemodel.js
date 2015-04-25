"use strict";

var url				= require("url");

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var GameModel		= rewire("../models/gamemodel.js");

describe("GameModel", function() {
	// STUBS
	var testMediaLocation
		, configHelperStub;

	describe("#validateId(id)", function() {
		it("validates if id is made of characters, digits, and '-'", function() {
			var id = "validid-123"
				, result;

			result = GameModel.validateId(id);
			expect(result).to.be.true;
		});

		it("fails if id contains special characters or whitespace", function() {
			var specialChars = "!@#$%^&*()_+=;:\"\'{}[]|\\?/<>,.\`~\n\t\0\r "
				, id
				, result;

			function testCharacter(char, index, array) {
				id = "invalid".concat(char,"id");
				result = GameModel.validateId(id);
				expect(result).to.equal(false, "Char: '".concat(id, "' is invalid"));
			}
			specialChars.split("").forEach(testCharacter);
		});

		it("fails if id is undefined", function() {
			var id = undefined
				, result;

			result = GameModel.validateId(id);
			expect(result).to.be.false;
		});
	});

	describe("#createModelFromAzureEntry(entry)", function() {
		// TEST DATA
		var testMediaLocation = "http://localhost:3000/testmedialocation";
		var testEntry =
			{
				RowKey: { _ : "rowkey"}
				, description: { _ : "description" }
				, title: { _ : "title" }
				, titleMediaUri: { _ : "titlemediauri.png" }
			};

		//
		// SETUP & TEARDOWN
		//
		before(function() {
			configHelperStub = sinon.stub().returns(testMediaLocation);
			GameModel.__set__({
				"ConfigHelper.getMediaLocation": configHelperStub
			});
		});

		afterEach(function() {
			configHelperStub.reset();
		});

		//
		//	SPEC
		//
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

		it("sets quotes to undefined by default", function() {
			var result;

			result = GameModel.createModelFromAzureEntry(testEntry);
			expect(result.quotes).to.be.undefined;
		});

		it("combines the media location and titleMediaUri into the titleMediaUri field", function() {
			var expected
				, result;

			expected = url.resolve(testMediaLocation, testEntry.titleMediaUri._);
			result = GameModel.createModelFromAzureEntry(testEntry);

			expect(result.titleMediaUri).to.equal(expected);
			expect(configHelperStub.called).to.be.true;
		});
	});
});
