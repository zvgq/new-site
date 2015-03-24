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
	ZVGQ.GameView = ZVGQ.GameView || { };

	# setup view
	ZVGQ.GameView.init = ()->
		masonryEl = document.getElementById "tileContainer"
		masonryOptions =
			itemSelector: ".tile"
		@msnry = new Masonry masonryEl, masonryOptions

	ZVGQ.GameView.init()
