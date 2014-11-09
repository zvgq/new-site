module.exports = (grunt)->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		clean:
			dev:
				options:
					force: true
				src: ["./**/*.js",
					  "./**/*.js.map",
					  "./client/style/*.css",
					  "!./client/lib/**/*.*", 
					  "!./node_modules/**/*.*",
					  "!./dist/**/*.*"
					 ]
			client:
				options:
					force: true
				src: ["./client/**/*.js", "./client/**/*.js.map", "!./client/lib/**/*.*", "!./dist/**/*.*"]
			server:
				options:
					force: true
				src: ["./**/*.js", "!./client/**/*.*", "!./node_modules/**/*.*", "!./dist/**/*.*"]
				
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
			buildweb:
				files: [
					{ expand: true, src: ["./config.json", "./package.json", "bower.json"], dest: "./dist/web" },
					{ expand: true, src: "./*.js", dest: "./dist/web" },
					{ expand: true, src: ["./client/**/*.js", "./client/**/*.json", "./client/**/*.css"], dest: "./dist/web" },
					{ expand: true, src: "./models/**/*.js", dest: "./dist/web" }, 
					{ expand: true, src: "./repositories/**/*.js", dest: "./dist/web" }, 
					{ expand: true, src: "./routers/**/*.js", dest: "./dist/web" }, 
					{ expand: true, src: ["./views/**/*.jade", "./views/**/*.html"], dest: "./dist/web" }, 
				]
					
		less:
			dev:
				options:
					cleancss: false
				files:
					"./client/style/main.css": "./client/style/main.less"
					
		nodemon:
			dev:
				script: "index.js"
				options:
					nodeArgs: ["--debug"]
					ignore: ['node_modules/**', 'client/**']
					
		watch:
			client:
				files: ["./client/**/*.coffee", "./client/**/*.less", "./views/*.html"]
				tasks: ["coffee:client","less:dev","copy:views"]
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
	grunt.registerTask 'client', 'Build all client content', ['clean:client', 'coffee:client', 'less:dev']
	grunt.registerTask 'server', 'Build all server content', ['clean:server','coffee:server']
	
	grunt.registerTask 'buildweb', 'Build the project into the dist/web', ["copy:buildweb"]
	
	grunt.registerTask 'f5', 'Build, run, and watch both client and server content', ['server', 'client', 'concurrent:start']
