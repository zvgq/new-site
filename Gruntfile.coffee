module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			dev: 
				options:
					force: true
				src:
					["./build/**/*.js", "!./build/public/bower_components/**/*.js", "./build/**/*.html", "./build/**/*.jade"]			
		coffee:
			dev:
				expand: true
				cwd: "./src"
				src: ["**/*.coffee", "!client/**/*.*"]
				dest: "./build"
				ext: ".js"
			browseclient:
				expand: true
				cwd: "./src/client/browse"
				src: "**/*.coffee"
				dest: "./build/public/script/browse"
				ext: ".js"
		copy:
			configuration:
				src: './src/config.json'
				dest: './config.json' 
			views:
                files:
                    "./build/views/browse.html": "./src/views/browse.html"
                    "./build/views/browse.jade": "./src/views/browse.jade"
			content:
				files:
					"./build/public/content/default-title.png": "./src/client/content/default-title.png"
		less:
			dev:
				options:
					cleancss: false
				files:
					"./build/public/style/main.css": "./src/client/style/main.less"
			
	# Plugins
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-less'

	# Tasks
	grunt.registerTask 'default', ['clean:dev', 'coffee:dev', 'copy:configuration', 'copy:views']
	grunt.registerTask 'client', ['coffee:browseclient', 'less:dev', 'copy:views', 'copy:content']