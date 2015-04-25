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

		$(".quote-list .quote").on "click", (event)->
			quoteIndex = $(event.delegateTarget).data("index");
			$("#quoteDisplay article[data-index='#{ quoteIndex }']").show();

		$("#quoteModal").on "hidden.bs.modal", (event)->
			$("#quoteDisplay article").hide()

	ZVGQ.GameView.init()
