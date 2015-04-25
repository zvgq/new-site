"use strict";

var expect          = require("chai").expect;
var sinon           = require("sinon");
var rewire			= require("rewire");

var GameModel		= rewire("../models/gamemodel.js");
var CatalogueRepository	= rewire("../repositories/cataloguerepository.js");

describe("CatalogueRepository", function() {
	// STUBS
	var createTableServiceStub
		, createTableStub
		, nconfGetStub
		, queryEntitiesStub
		, retrieveEntityStub
		, sampleEntry
		, sampleTableName = "SAMPLETABLE"

	// DEFAULT SETUP FOR TESTS
	beforeEach(function() {
		// stub nconf
		nconfGetStub		= sinon.stub();
		nconfGetStub.withArgs("CATALOGUE_TABLE_NAME").returns(sampleTableName);

		// table service mock
		sampleEntry = {
			id: "testid"
			, description: "testdescription"
			, title: "testtitle"
			, titleMediaUri: "testtitlemediauri.png"
			, quotes: undefined
		};
		CatalogueRepository.__set__({
			"nconf.get": nconfGetStub
		});
		retrieveEntityStub = sinon.stub().callsArgWith(3, null, sampleEntry);
		queryEntitiesStub = sinon.stub().callsArgWith(3, null, {entries: []});
		createTableStub = sinon.stub().callsArg(1);

		var tableServiceMock = {
			queryEntities: queryEntitiesStub
			, createTableIfNotExists: createTableStub
			, retrieveEntity: retrieveEntityStub
		};
		createTableServiceStub 	= sinon.stub().returns(tableServiceMock);

		// azure mock
		var azureMock = {
			createTableService: createTableServiceStub
		};
		CatalogueRepository.__set__({
			"azure.createTableService": createTableServiceStub
		});
	});

	afterEach(function() {
		createTableServiceStub.reset();
		createTableStub.reset();
		queryEntitiesStub.reset();
		nconfGetStub.reset();
	});

	describe("#constructor()", function() {
		// SPECS
		it("creates a table service", function() {
			var repository = new CatalogueRepository();

			expect(createTableServiceStub.calledOnce).to.be.true;
		});

		it("attempts to create table with same name as config entry", function() {
			var repository = new CatalogueRepository();

			expect(createTableStub.calledOnce).to.be.true;
			expect(createTableStub.calledWith(sampleTableName)).to.be.true;
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
			var azureMock = { createTableService: createTableServiceStub };
			CatalogueRepository.__set__({
				"azure.createTableService": createTableServiceStub
			});

			// GIVEN
			var repository;
			try {
				repository = new CatalogueRepository();
			}
			catch(ex) { }

			// WHEN
			expect(createTableStub.calledOnce).to.be.true;

			// THEN
			expect(createTableStub.threw()).to.be.true;
		});
	});

	describe("#getGames(filter, callback)", function() {
		var newQueryHelperSpy
			, numQueryHelperSpy
			, letterQueryHelperSpy;

		before(function() {
			newQueryHelperSpy 		= sinon.spy();
			numQueryHelperSpy 		= sinon.spy();
			letterQueryHelperSpy 	= sinon.spy();

			CatalogueRepository.__set__({
				"getNewQuery": newQueryHelperSpy
				, "getNumberQuery": numQueryHelperSpy
				, "getLetterQuery": letterQueryHelperSpy
			});
		});

		afterEach(function() {
			newQueryHelperSpy.reset();
			numQueryHelperSpy.reset();
			letterQueryHelperSpy.reset();
		});

		it("queries entries from storage", function(done) {
			var filter	= "new"
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
					expect(err).not.to.exist;
					expect(result.entries).to.be.instanceOf(Array);
					done();
				});
			repository.getGames(filter, cbSpy);

			expect(queryEntitiesStub.calledOnce).to.be.true;
			expect(cbSpy.calledOnce).to.be.true;
		});

		it("converts each entry returned", function() {
			// STUBS & MOCKS
			var testEntries = ["sample1", "sample2", "sample3"];
			queryEntitiesStub = sinon.stub().callsArgWith(3, null, {entries: testEntries});
			createTableStub = sinon.stub().callsArgWith(1, null);
			var tableServiceMock = {
				queryEntities: queryEntitiesStub
				, createTableIfNotExists: createTableStub
			};
			createTableServiceStub 	= sinon.stub().returns(tableServiceMock);

			// azure mock
			var azureMock = {
				createTableService: createTableServiceStub
			};
			CatalogueRepository.__set__({
				"azure.createTableService": createTableServiceStub
			});

			// model mock
			var createModelFromAzureEntryStub = sinon.stub();
			CatalogueRepository.__set__({
				"GameModel.createModelFromAzureEntry": createModelFromAzureEntryStub
			});

			// GIVEN
			var filter = "new"
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy();

			// WHEN
			repository.getGames(filter, cbSpy);

			// THEN
			expect(createModelFromAzureEntryStub.callCount).to.equal(testEntries.length);
		});

		it("returns error and no results on invalid filter", function(done) {
			var invalidFilter = ""
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(err).to.exist;
							expect(result).not.to.exist;
							done();
							});

			repository.getGames(invalidFilter, cbSpy);
		});

		it("creates a 'new' query when passed 'new' as filter", function(done) {
			var filterValue = "new"
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(err).not.to.exist;
							expect(result.filter).to.equal(filterValue);
							expect(newQueryHelperSpy.calledOnce).to.be.true;
							expect(numQueryHelperSpy.callCount).to.equal(0);
							expect(letterQueryHelperSpy.callCount).to.equal(0);
							done();
							});

			repository.getGames(filterValue, cbSpy);
		});

		it("creates a 'num' query when passed 'num' as filter", function(done) {
			var filterValue = "num"
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(err).not.to.exist;
							expect(result.filter).to.equal(filterValue);
							expect(numQueryHelperSpy.calledOnce).to.be.true;
							expect(newQueryHelperSpy.callCount).to.equal(0);
							expect(letterQueryHelperSpy.callCount).to.equal(0);
							done();
							});

			repository.getGames(filterValue, cbSpy);
		});

		it("creates a 'letter' query when passed a letter as a filter", function(done) {
			var filterValue = "a"
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(err).not.to.exist;
							expect(result.filter).to.equal(filterValue);
							expect(letterQueryHelperSpy.calledOnce).to.be.true;
							expect(newQueryHelperSpy.callCount).to.equal(0);
							expect(numQueryHelperSpy.callCount).to.equal(0);
							done();
							});

			repository.getGames(filterValue, cbSpy);
		});
	});

	describe("#getGame(id, withQuotes, callback)", function() {

		it("retrieves the game", function(done) {
			var repository = new CatalogueRepository()
				, cbStub = sinon.spy(function(err, result) {
								expect(retrieveEntityStub.calledOnce).to.be.true;
								done();
								});

			repository.getGame("testid", false, cbStub);
		});

		it("converts retrieved entity", function(done) {
			var createModelFromAzureEntryStub = sinon.stub();
			CatalogueRepository.__set__({
				"GameModel.createModelFromAzureEntry": createModelFromAzureEntryStub
			});

			var repository = new CatalogueRepository()
			, cbSpy = sinon.spy(function(err, result) {
							expect(createModelFromAzureEntryStub.calledOnce).to.be.true;
							done();
							});

			repository.getGame("testid", false, cbSpy);
		});

		it("returns an array of quotes for the game if withQuotes parameter is true", function(done) {
			var createModelFromAzureEntryStub
				, testModel = new GameModel()
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(result.quotes).to.exist;
							expect(result.quotes).to.be.instanceOf(Array);
							done();
							});

			// setup
			testModel.id = "testid";
			createModelFromAzureEntryStub = sinon.stub().returns(testModel);
			CatalogueRepository.__set__({
				"GameModel.createModelFromAzureEntry": createModelFromAzureEntryStub
			});

			repository.getGame("testid", true, cbSpy);
		});

		it("leaves quotes to undefined if withQuotes parameter is false", function(done) {
			var createModelFromAzureEntryStub
				, repository = new CatalogueRepository()
				, cbSpy = sinon.spy(function(err, result) {
							expect(result.quotes).to.be.undefined;
							done();
							});

			// setup
			createModelFromAzureEntryStub = sinon.stub().returns(new GameModel());
			CatalogueRepository.__set__({
				"GameModel.createModelFromAzureEntry": createModelFromAzureEntryStub
			});

			repository.getGame("testid", false, cbSpy);
		});

		it("returns 'invalid id: <id>' error on invalid id", function(done) {
			var invalidId = "+++"
			, repository = new CatalogueRepository()
			, cbStub = sinon.spy(function(err, result) {
				expect(err).to.equal("invalid id: ".concat(invalidId));
				expect(retrieveEntityStub.callCount).to.equal(0);
				done();
				});

			repository.getGame(invalidId, false, cbStub);
		});
	});

	describe("#validateFilter(filter)", function() {
		it("returns true if filter is 'num', or 'new'", function() {
			var result;

			result = CatalogueRepository.validateFilter('new');
			expect(result).to.be.eql(true, "Failed on 'new'");

			result = CatalogueRepository.validateFilter('num');
			expect(result).to.be.eql(true, "Failed on 'num'");

			// negative tests
			result = CatalogueRepository.validateFilter('NEW');
			expect(result).to.be.eql(false, "Failed on 'NEW'");

			result = CatalogueRepository.validateFilter('NUM');
			expect(result).to.be.eql(false, "Failed on 'NUM'");
		});

		it("returns true if filter is a single lower case letter", function() {
			var result;

			result = CatalogueRepository.validateFilter('a');
			expect(result).to.be.eql(true, "Failed on 'a'");

			result = CatalogueRepository.validateFilter('A');
			expect(result).to.be.eql(true, "Failed on 'A'");

			// negative testing
			result =  CatalogueRepository.validateFilter('aa');
			expect(result).to.be.eql(false, "Failed on 'aa'");

			result =  CatalogueRepository.validateFilter('AA');
			expect(result).to.be.eql(false, "Failed on 'AA'");

			result =  CatalogueRepository.validateFilter('1');
			expect(result).to.be.eql(false, "Failed on '1'");

			result =  CatalogueRepository.validateFilter('11');
			expect(result).to.be.eql(false, "Failed on '11'");

			result =  CatalogueRepository.validateFilter('a1');
			expect(result).to.be.eql(false, "Failed on 'a1'");

			result =  CatalogueRepository.validateFilter('');
			expect(result).to.be.eql(false, "Failed on ''");

			result =  CatalogueRepository.validateFilter(1);
			expect(result).to.be.eql(false, "Failed on 1");
		});
	});
});
