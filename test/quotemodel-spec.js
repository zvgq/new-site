"use strict";

var path			= require("path");

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var QuoteModel		= rewire("../models/quotemodel.js");

describe("QuoteModel", function() {
	describe("#createModelFromAzureEntry(entry)", function() {
		// SHARED VARIABLES
		var testEntry
			, testLocationUrl
			, returnEmptyEntry;

		beforeEach(function() {
			// TEST DATA
			testEntry = {
				PartitionKey: { _:"zvgq-quote" }
				, RowKey: { _:"quoteidsample" }
				, gameId: { _:"gameidsample" }
				, title: { _:"title" }
				, description: { _:"sample description" }
				, titleMediaUri: { _:"sampletitlemediauri.png" }
				, mediaUri: { _:"samplemediauri.png" }
			};

			returnEmptyEntry = {
				PartitionKey: { _: "zvgq-quote" }
				, RowKey: { _: "sampleid" }
				, gameId: { _: "samplegameid" }
			};

			testLocationUrl = "https://localhost:3000/testmedialocation";
		});

		it("copies RowKey to id", function() {
			var result;

			result = QuoteModel.createModelFromAzureEntry(testEntry);
			expect(result.id).to.equal(testEntry.RowKey._);
		});

		it("copies title to title", function() {
			var result;

			result = QuoteModel.createModelFromAzureEntry(testEntry);
			expect(result.title).to.equal(testEntry.title._);
		});

		it("copies gameId to gameId", function() {
			var result;

			result = QuoteModel.createModelFromAzureEntry(testEntry);
			expect(result.gameId).to.equal(testEntry.gameId._);
		});

		it("combines media location URL mediaUri to the mediaUri", function() {
			var result
				, expected
				, configHelperStub;

			// setup test
			configHelperStub = sinon.stub().returns(testLocationUrl);
			QuoteModel.__set__({
				"ConfigHelper.getMediaLocation" : configHelperStub
			});

			// expected result
			expected = path.join(testLocationUrl, testEntry.mediaUri._)

			// test
			result = QuoteModel.createModelFromAzureEntry(testEntry);
			expect(result.mediaUri).to.equal(expected);
		});

		it("combines media location URL mediaUri to the mediaUri", function() {
			var result
				, expected
				, configHelperStub;

			// setup test
			configHelperStub = sinon.stub().returns(testLocationUrl);
			QuoteModel.__set__({
				"ConfigHelper.getMediaLocation" : configHelperStub
			});

			// expected result
			expected = path.join(testLocationUrl, testEntry.titleMediaUri._)

			result = QuoteModel.createModelFromAzureEntry(testEntry);
			expect(result.titleMediaUri).to.equal(expected);
		});

		it("sets title as null if title is undefined on entry", function() {
			var result;

			result = QuoteModel.createModelFromAzureEntry(returnEmptyEntry);
			expect(result).not.to.be.null;
			expect(result.title).to.be.null;
		});

		it("sets mediaUri as null if mediaUri is undefined on entry", function() {
			var result;

			result = QuoteModel.createModelFromAzureEntry(returnEmptyEntry);
			expect(result).not.to.be.null;
			expect(result.mediaUri).to.be.null;
		});

		it("sets titleMediaUri as null if titleMediaUri is undefined on entry", function() {
			var result;

			result = QuoteModel.createModelFromAzureEntry(returnEmptyEntry);
			expect(result).not.to.be.null;
			expect(result.titleMediaUri).to.be.null;
		});

		describe("returns null", function() {
			it("if RowKey is undefined on entry", function() {
				var result
					, testInvalidEntry = {
						PartitionKey: { _:"zvgq-quote" }
					};

				result = QuoteModel.createModelFromAzureEntry(testInvalidEntry);
				expect(result).to.be.null;
			});

			it("if testEntry.PartitionKey is NOT zvgq-quote", function() {
				var result
					, testEntry = {
						PartitionKey: "zvgq-game"
					}
					, spy = sinon.spy();

				result = QuoteModel.createModelFromAzureEntry(testEntry);
				expect(result).to.be.null;
			});

			it("if gameId is undefined on entry", function() {
				var result
					, testInvalidEntry = {
						PartitionKey: { _:"zvgq-quote" }
						, RowKey: { _: "sampleid" }
					};

				result = QuoteModel.createModelFromAzureEntry(testInvalidEntry);
				expect(result).to.be.null;
			});
		});
	});
});
