"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var Game			= require("../models/gamemodel");
var GameRepository	= rewire("../repositories/gamerepository.js");

describe("Game Repository", function() {

	var repository;

	describe("is constructed", function() {
		it("creates a table service", function() {
			// setup
			var createTableServiceStub = sinon.stub().returns();
			var azureMock =
				{
					createTableService: createTableServiceStub
				};
			GameRepository.__set__("azure", azureMock);

			repository = new GameRepository();

			expect(createTableServiceStub.calledOnce).to.be.true;
		});
	});

	describe("#getGames(filter)", function() {

	});
});
