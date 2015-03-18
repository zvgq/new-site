require.config
	baseUrl: "/lib"
	paths:
		"bootstrap": "bootstrap/js"
		"jquery": "jquery/dist/jquery.min"
		"masonry": "masonry/masonry"
	shim:
		"bootstrap":
			deps: "jquery"
			exports: "Bootstrap"

require [
	"jquery", "masonry"
], ($, Masonry)->
	# setup namespaces
	ZVGQ = ZVGQ || { };
	ZVGQ.Games = ZVGQ.Games || { };

	# setup view
	ZVGQ.Games.init = ()->
		masonryEl = document.getElementById "tileContainer"
		masonryOptions =
			itemSelector: ".tile"
		@msnry = new Masonry masonryEl, masonryOptions

	ZVGQ.Games.init()
