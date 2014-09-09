requirejs.config
	baseUrl: "/script"
	shim:
		"bootstrap":
			"deps": [
				"jquery"
			]
			"exports":
				"Bootstrap"
	paths:
		"jquery": "../bower_components/jquery/dist/jquery"
		"bootstrap": "../bower_components/bootstrap/dist/js/bootstrap.min.js"

require [
	"jquery"
	"bootstrap"
], ($, Bootstrap)->
    alert "Hello from Script!"