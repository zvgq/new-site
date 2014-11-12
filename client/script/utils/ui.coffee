define ["jquery", "masonry", "utils/ui"],
	($, Masonry)->		
		ui = 
			remason: ()->
				masonryEl = document.getElementById "tileContainer"
				masonryOptions = 
					itemSelector: ".tile"
				@msnry = new Masonry masonryEl, masonryOptions
			
		return ui