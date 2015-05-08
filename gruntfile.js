module.exports = function (grunt) {
	// initialize
	grunt.initConfig({
		// grunt-babel
		babel: {
			dist: {
				files: {
					"dist/script/gameviewhelper.js": "client/script/gameviewhelper.js"
				}
			}
		},

		// mocha-phantomjs
		mocha_phantomjs: {
			client: ['client/test/*.html']
		}
	});

	// load plugins
	grunt.loadNpmTasks('grunt-babel');
	grunt.loadNpmTasks('grunt-mocha-phantomjs');

	// project tasks
	grunt.registerTask('default','Runs the dev build process', ['dev']);

	grunt.registerTask('dev', 'Build and Test for local development', ['babel','mocha_phantomjs:client']);
};
