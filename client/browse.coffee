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
	$, "masonry"
], (jquery, Masonry)->
	ZVGQ = ZVGQ || { };
	ZVGQ.Browse = ZVGQ.Browse || { };
