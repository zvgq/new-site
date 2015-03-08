class User
    constructor: (data)->
        @providerUID    = data.providerUID
        @email          = data.email
        @displayName    = data.displayName

module.exports = User
