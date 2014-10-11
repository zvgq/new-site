module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			client:
				options:
					force: true
				src: ["./dist/client/**/*.*","!./dist/bower_components/**/*.*"]
			server:
				options:
					force: true
				src: ["./dist/**/*.*", "./dist/**/*.html", "./dist/**/*.jade", "!./dist/public/**/*.*"]		
				
		coffee:
			client:
				expand: true
				cwd: "./src/client"
				src: ["**/*.coffee"]
				dest: "./dist/client"
				ext: ".js"
			server:
				expand: true
				cwd: "./src/server"
				src: ["**/*.coffee"]
				dest: "./dist"
				ext: ".js"

		copy:				
			configuration:
				src: './src/config.json'
				dest: './config.json' 
			views:
                files:
                    "./dist/views/browse.html": "./src/views/browse.html"
                    "./dist/views/browse.jade": "./src/views/browse.jade"
			content:
				files:
					"./dist/client/content/default-title.png": "./src/client/content/default-title.png"
					
		less:
			dev:
				options:
					cleancss: false
				files:
					"./dist/client/style/main.css": "./src/client/style/main.less"
			
	# Plugins
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-less'

	# Tasks
	grunt.registerTask 'client', ['clean:client', 'coffee:client', 'less:dev', 'copy:views', 'copy:content']
	grunt.registerTask 'server', ['clean:server','coffee:server','copy:configuration']
	grunt.registerTask 'default', ['server', 'client']