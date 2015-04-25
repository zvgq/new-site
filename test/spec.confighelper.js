"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var ConfigHelper	= rewire("../utils/confighelper.js");

describe("ConfigHelper", function() {
	describe("#getMediaLocation()", function() {
		//
		//	SHARED TEST VARIABLES
		//
		var nconfGetStub
			, testMediaLocation;

		//
		//	SETUP & TEARDOWN
		//
		before(function() {
			// setup shared variables
			testMediaLocation = "http://localhost:3000/testmedialocation";
			nconfGetStub = sinon.stub().withArgs("MEDIA_LOCATION").returns(testMediaLocation);

			// rewire
			ConfigHelper.__set__({
				"nconf.get": nconfGetStub
			});
		});

		afterEach(function() {
			nconfGetStub.reset();
		});

		//
		//	SPECS
		//
		it("returns a string from the config file, if found", function() {
			var result;

			result = ConfigHelper.getMediaLocation();
			expect(nconfGetStub.calledOnce).to.be.true;
		});

		it("uses MEDIA_LOCATION for the key", function() {
			var result;

			result = ConfigHelper.getMediaLocation();
			expect(nconfGetStub.alwaysCalledWith("MEDIA_LOCATION")).to.be.true;
		});

		it("returns null if not found", function() {
			var result,
				nconfGetSpy;

			// setup fail conditions
			nconfGetSpy = sinon.spy();
			ConfigHelper.__set__({
				"nconf.get": nconfGetSpy
			});

			result = ConfigHelper.getMediaLocation();
			expect(result).to.be.null;
		});
	});
});
