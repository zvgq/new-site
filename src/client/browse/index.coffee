requirejs.config
	paths:
		'semantic-ui' : '/bower_components/semantic-ui/build/packaged/javascript/semantic.min'
	shim:
		'semantic-ui':
			exports: 'SemanticUI'

require ['semantic-ui'], (SemanticUI)->
	if SemanticUI
		alert 'SemanticUI loaded successfully'