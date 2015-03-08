User = require "../models/usermodel"

class UserRepository
    constructor: (ds)->
        @dataService = ds;

    validateId = (id)->
        isValid = (typeof(id) is "string") and (id isnt "")

        return isValid;

    ### callback(user, err) ###
    getUser: (id, callback)->
        if validateId(id) is true
            @dataService.retrieveEntity id

            userData =
                providerUID: "uniqueID"
                displayName: "Sample Name"
                email: "sample@a.com"
            callback new User(userData), null
        else
            callback null, "invalid id"

module.exports = UserRepository
