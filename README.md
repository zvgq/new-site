zvgq
====
The "New" Zany Video Game Quotes web site.

## URLs and API

### Client API
- GET /games/:filter
	- :filter, The filter criteria to  (Default = new)
	- List all games based on "filter" parameter.
- GET /game/:id
	- :id, The unique identifier for the game being displayed
	- Empty :id redirects to /games/new
- GET /game/:id/quote/:quote_id
	- :quote_id, The unique identifier for the quote being displayed
  
### Server API
- GET /api/games?filter=filtervalue
	- List games based on filter
	- Accepted Values
		- new, games wth new content (e.g. newly added, updated recently)
		- num, games that start with a number (e.g. 8 Eyes)
		- a-z, games that start with a letter

## Development Environment