var expect          = require("chai").expect;
var sinon           = require("sinon");

var UserRepository  = require("../repositories/userrepository");
var User            = require("../models/usermodel");

describe.skip("UserRepository", function() {
    describe("getUser(id)", function() {
        var retrieveStub;
        var repository;

        // data service object
        var ds = {
            retrieveEntity: function(id, callback) {}
        };

        beforeEach(function() {
            retrieveStub    = sinon.stub(ds, "retrieveEntity");
            repository      = new UserRepository(ds);
        });

        afterEach(function() {
            retrieveStub.restore();
        });

        it("should return User object with providerUID, email, and displayName properties", function(done) {
            repository.getUser("123", function(user, err) {
                // validate user
                expect(user).to.be.an.instanceof(User);
                expect(user.email).not.to.be.empty;
                expect(user.providerUID).not.to.be.empty;
                expect(user.displayName).not.to.be.empty;

                expect(err).to.be.null;
                done();
            });
        });

        it("should return null user with error message on invalid ID", function(done) {
            repository.getUser(123, function(user, err) {
                expect(user).to.be.null;
                expect(err).to.exist;
                done();
            });
        });

        it("should only retrieve an entity once", function(done){
            repository.getUser("123", function(user, err) {
                expect(retrieveStub.calledOnce).to.be.true;
                done();
            });
        });
    });
});
