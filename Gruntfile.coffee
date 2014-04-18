module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			dev: 
				options:
					force: true
				src:
					["./build/**/*.js", "!./build/public/bower_components/**/*.js", "./build/**/*.hbs"]
			devclient:
				options:
					force: true
				src:
					["./build/**/*.hbs"]				
		coffee:
			dev:
				expand: true
				cwd: "./src"
				src: ["**/*.coffee", "!public/**/*.*"]
				dest: "./build"
				ext: ".js"
			devclient:
				expand: true
				cwd: "./src/public"
				src: "**/*.coffee"
				dest: "./build/public/script"
				ext: ".js"
		copy:
			configuration:
				src: './config.json'
				dest: './src/config.json' 
			views:
				src: './src/views/browse.handlebars'
				dest: './build/views/browse.handlebars'
		less:
			dev:
				options:
					cleancss: false
				files:
					"./build/public/style/main.css": "./src/public/style/main.less"
			
					

	# Plugins
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-less'

	# Tasks
	grunt.registerTask 'default', ['clean:dev', 'coffee:dev', 'coffee:devclient', 'copy:configuration', 'copy:views']
	grunt.registerTask 'client', ['clean:devclient', 'coffee:devclient', 'less:dev', 'copy:views']