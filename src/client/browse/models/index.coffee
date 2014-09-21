define ["ember-data", "./browse/models/gamemodel"],
	(DS, GameModel)->
		setup: ()->
			ZVGQBrowse.Game = GameModel
			ZVGQBrowse.Game.FIXTURES = [
				{ 
					"id": "shadowgate"
					"title": "Shadowgate"
					"titleMediaUri": "/content/default-title.png"
					"description": "Shadowgate on the NES"
				}
				{ 
					"id": "shadowgate-2014"
					"title": "Shadowgate (2014)"
					"titleMediaUri": "/content/default-title.png"
					"description": "Shadowgate on the PC by Zojoi" 
				}
			]