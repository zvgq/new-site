"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var Game			= require("../models/gamemodel");
var GameRepository	= rewire("../repositories/gamerepository.js");

// mocks
var azure			= require("azure-storage");

describe("Game Repository", function() {
	// STUBS
	var createTableServiceStub
		, queryEntitiesStub;

	// SETUP ON ALL TESTS
	before(function() {
		queryEntitiesStub		= sinon.stub();
		var tableServiceMock = {
			queryEntities: queryEntitiesStub
		};
		createTableServiceStub 	= sinon.stub().returns(tableServiceMock);

		var azureMock = {
			createTableService: createTableServiceStub
		}
		GameRepository.__set__({
			"azure.createTableService": createTableServiceStub
		});
	});

	afterEach(function() {
		createTableServiceStub.reset();
		queryEntitiesStub.reset();
	});


	describe("on initialization", function() {
		// SPECS
		it("creates a table service", function() {
			var repository = new GameRepository();

			expect(createTableServiceStub.calledOnce).to.be.true;
		});
	});

	describe("#getGames(filter, callback)", function() {
		it("queries entities from storage", function() {
			var filter	= "new"
				, repository = new GameRepository()
				, cbSpy = sinon.spy();
			repository.getGames(filter, cbSpy);

			expect(queryEntitiesStub.calledOnce).to.be.true;
		});

		it("returns error and no results on invalid filter", function(done) {
			var invalidFilter = ""
				, repository = new GameRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(err).to.exist;
							expect(result).not.to.exist;
							done();
							});

			repository.getGames(invalidFilter, cbSpy);
		});
	});

	describe("#validateFilter(filter)", function() {
		it("returns true if filter is 'num', or 'new'", function() {
			var result;

			result = GameRepository.validateFilter('new');
			expect(result).to.be.eql(true, "Failed on 'new'");

			result = GameRepository.validateFilter('num');
			expect(result).to.be.eql(true, "Failed on 'num'");

			// negative tests
			result = GameRepository.validateFilter('NEW');
			expect(result).to.be.eql(false, "Failed on 'NEW'");

			result = GameRepository.validateFilter('NUM');
			expect(result).to.be.eql(false, "Failed on 'NUM'");
		});

		it("returns true if filter is a single lower case letter", function() {
			var result;

			result = GameRepository.validateFilter('a');
			expect(result).to.be.eql(true, "Failed on 'a'");

			result = GameRepository.validateFilter('A');
			expect(result).to.be.eql(true, "Failed on 'A'");

			// negative testing
			result =  GameRepository.validateFilter('aa');
			expect(result).to.be.eql(false, "Failed on 'aa'");

			result =  GameRepository.validateFilter('AA');
			expect(result).to.be.eql(false, "Failed on 'AA'");

			result =  GameRepository.validateFilter('1');
			expect(result).to.be.eql(false, "Failed on '1'");

			result =  GameRepository.validateFilter('11');
			expect(result).to.be.eql(false, "Failed on '11'");

			result =  GameRepository.validateFilter('a1');
			expect(result).to.be.eql(false, "Failed on 'a1'");

			result =  GameRepository.validateFilter('');
			expect(result).to.be.eql(false, "Failed on ''");

			result =  GameRepository.validateFilter(1);
			expect(result).to.be.eql(false, "Failed on 1");
		});
	});
});
