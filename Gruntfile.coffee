module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			dev:
				options:
					force: true
				src: ["./**/*.js", 
					  "!./client/lib/**/*.*", 
					  "!./node_modules/**/*.*",
					 "./**/*.js.map",
					 ]
			client:
				options:
					force: true
				src: ["./client/**/*.js", "./client/**/*.js.map", "!./client/lib/**/*.*"]
			server:
				options:
					force: true
				src: ["./**/*.js", "!./client/**/*.*", "!./node_modules/**/*.*"]
				
		coffee:
			client:
				expand: true
				cwd: "./client"
				src: ["./**/*.coffee"]
				dest: "./client"
				ext: ".js"
				options:
					sourceMap: true
			server:
				expand: true
				cwd: "./"
				src: ["./**/*.coffee","!./client","!./Gruntfile.coffee"]
				dest: "./"
				ext: ".js"
			dev:
				expand: true
				cwd: "./"
				src: ["./**/*.coffee","!./client/lib","!./Gruntfile.coffee"]
				dest: "./"
				ext: ".js"

		concurrent:
			start: ["watch:client", "watch:server", "nodemon:dev"]
			options:
				logConcurrentOutput: true
				
		copy:				
			configuration:
				src: './config.json'
				dest: './config.json' 
			views:
                files:
                    "./dist/views/browse.html": "./server/views/browse.html"
                    "./dist/views/browse.jade": "./server/views/browse.jade"
			content:
				files:
					"./dist/client/content/default-title.png": "./client/content/default-title.png"
					
		less:
			dev:
				options:
					cleancss: false
				files:
					"./client/style/main.css": "./client/style/main.less"
					
		nodemon:
			dev:
				script: "./index.js"
				options:
					nodeArgs: ["--debug"]
					ignore: ['node_modules/**', 'client/**']
					
		watch:
			client:
				files: ["./client/**/*.coffee"]
				tasks: ["coffee:client"]
			server:
				files: ["./**/*.coffee","!./client/**/*.*"]
				tasks: ["coffee:server"]
			
	# Plugins
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-nodemon'
	grunt.loadNpmTasks 'grunt-concurrent'

	# Tasks
	grunt.registerTask 'client', ['clean:client', 'coffee:client']
	grunt.registerTask 'server', ['clean:server','coffee:server']
	
	grunt.registerTask 'default', ['server', 'client', 'concurrent:start']
