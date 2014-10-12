module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			client:
				options:
					force: true
				src: ["./dist/client/**/*.*","!./dist/client/lib/**/*.*"]
			server:
				options:
					force: true
				src: ["./dist/**/*.*", "./dist/**/*.html", "./dist/**/*.jade", "!./dist/client/**/*.*"]
				
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

		concurrent:
			start: ["watch:client", "watch:server", "nodemon:dev"]
			options:
				logConcurrentOutput: true
				
		copy:				
			configuration:
				src: './src/config.json'
				dest: './config.json' 
			views:
                files:
                    "./dist/views/browse.html": "./src/server/views/browse.html"
                    "./dist/views/browse.jade": "./src/server/views/browse.jade"
			content:
				files:
					"./dist/client/content/default-title.png": "./src/client/content/default-title.png"
					
		less:
			dev:
				options:
					cleancss: false
				files:
					"./dist/client/style/main.css": "./src/client/style/main.less"
					
		nodemon:
			dev:
				script: "./dist/index.js"
				options:
					nodeArgs: ["--debug"]
					ignore: ['node_modules/**', 'dist/client/**']
					
		watch:
			client:
				files: ["./src/client/**/*.coffee"]
				tasks: ["coffee:client"]
			server:
				files: ["./src/server/**/*.coffee"]
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
	grunt.registerTask 'client', ['clean:client', 'coffee:client', 'less:dev', 'copy:views', 'copy:content']
	grunt.registerTask 'server', ['clean:server','coffee:server','copy:configuration']
	
	grunt.registerTask 'default', ['server', 'client', 'concurrent:start']
