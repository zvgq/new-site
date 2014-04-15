module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			dev: 
				options:
					force: true
				src:
					["./build/**/*.js", "./build/**/*.hbs"]
		coffee:
			dev:
				expand: true
				cwd: "./src"
				src: "**/*.coffee"
				dest: "./build"
				ext: ".js"
		copy:
			configuration:
				src: './config.json'
				dest: './src/config.json' 
			views:
				src: './src/views/browse.handlebars'
				dest: './build/views/browse.handlebars'
					

	# Plugins
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'

	# Tasks
	grunt.registerTask 'default', ['clean:dev', 'coffee:dev', 'copy:configuration', 'copy:views']