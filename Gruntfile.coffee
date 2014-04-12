module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			dev: 
				options:
					force: true
				src:
					["./build/**/*.js"]
		coffee:
			dev:
				expand: true
				cwd: "./src"
				src: "**/*.coffee"
				dest: "./build"
				ext: ".js"
		copy:
			configuration:
				files:
					'./config.json' : './src/config.json'
					

	# Plugins
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'

	# Tasks
	grunt.registerTask 'default', ['clean:dev', 'coffee:dev', 'copy:configuration']