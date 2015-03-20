"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var GameRepository	= rewire("../repositories/gamerepository.js");

// mocks
var azure			= require("azure-storage");

describe("GameRepository", function() {
	// STUBS
	var createTableServiceStub
		, createTableStub
		, queryEntitiesStub;

	// DEFAULT SETUP FOR TESTS
	beforeEach(function() {
		// table service mock
		queryEntitiesStub = sinon.stub().callsArgWith(3, null, {entries: []});
		createTableStub = sinon.stub().callsArg(1);
		var tableServiceMock = {
			queryEntities: queryEntitiesStub
			, createTableIfNotExists: createTableStub
		};
		createTableServiceStub 	= sinon.stub().returns(tableServiceMock);

		// azure mock
		var azureMock = {
			createTableService: createTableServiceStub
		};
		GameRepository.__set__({
			"azure.createTableService": createTableServiceStub
		});
	});

	afterEach(function() {
		createTableServiceStub.reset();
		createTableStub.reset();
		queryEntitiesStub.reset();
	});


	describe("on initialization", function() {
		// SPECS
		it("creates a table service", function() {
			var repository = new GameRepository();

			expect(createTableServiceStub.calledOnce).to.be.true;
		});

		it("attempts to create 'games' table", function() {
			var repository = new GameRepository();

			expect(createTableStub.calledOnce).to.be.true;
			expect(createTableStub.calledWith('games')).to.be.true;
		});

		it("throws error if fails on creating table", function() {
			// STUBS & MOCKS
			queryEntitiesStub = sinon.stub().callsArgWith(3, null, {entries: []});
			createTableStub = sinon.stub().callsArgWith(1, "test error");
			var tableServiceMock = {
				queryEntities: queryEntitiesStub
				, createTableIfNotExists: createTableStub
			};
			createTableServiceStub 	= sinon.stub().returns(tableServiceMock);

			// azure mock
			var azureMock = {
				createTableService: createTableServiceStub
			};
			GameRepository.__set__({
				"azure.createTableService": createTableServiceStub
			});

			// GIVEN
			var repository;
			try {
				repository = new GameRepository();
			}
			catch(ex) { }

			// WHEN
			expect(createTableStub.calledOnce).to.be.true;

			// THEN
			expect(createTableStub.threw()).to.be.true;
		});
	});

	describe("#getGames(filter, callback)", function() {
		it("queries entries from storage", function(done) {
			var filter	= "new"
				, repository = new GameRepository()
				, cbSpy = sinon.spy(function(err, result) {
					expect(err).not.to.exist;
					expect(result.entries).to.be.instanceOf(Array);
					done();
				});
			repository.getGames(filter, cbSpy);

			expect(queryEntitiesStub.calledOnce).to.be.true;
			expect(cbSpy.calledOnce).to.be.true;
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
