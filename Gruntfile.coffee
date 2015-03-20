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
					  "!./dist/**/*.*",
					  "!./test/**/*.*",
					  "!./repositories/**/*.*"
					  "!./models/**/*.*"
					 ]
			client:
				options:
					force: true
				src: ["./client/**/*.js", "./client/**/*.js.map", "!./client/lib/**/*.*", "!./dist/**/*.*", "!./test/**/*.*", "!./repositories/**/*.*", "!./models/**/*.*"]
			server:
				options:
					force: true
				src: ["./**/*.js", "!./client/**/*.*", "!./node_modules/**/*.*", "!./dist/**/*.*", "!./test/**/*.*", "!./repositories/**/*.*", "!./models/**/*.*"]

		coffee:
			client:
				expand: true
				cwd: "./client"
				src: ["./**/*.coffee"]
				dest: "./client"
				ext: ".js"
				options:
					sourceMap: true
					bare: true
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
			prod:
				expand: true
				cwd: "./"
				src: ["./**/*.coffee", "!./client/lib","!./Gruntfile.coffee","!./node_modules","!./dist"]
				dest: "./dist/web"
				ext: ".js"

		concurrent:
			start: ["watch:client", "nodemon:dev"]
			options:
				logConcurrentOutput: true

		copy:
			configuration:
				files:
					"./dist/web/package.json" : "./package.json"
					"./dist/web/config.json" : "./config.json"
					"./dist/web/.bowerrc" : "./.bowerrc"
					"./dist/web/bower.json" : "./bower.json"
					"./dist/web/.deployment" : "./.deployment"
					"./dist/web/deploy.cmd" : "./deploy.cmd"
			views:
                files:
                    "./dist/views/browse.html": "./server/views/browse.html"
                    "./dist/views/browse.jade": "./server/views/browse.jade"
			content:
				files:
					"./dist/client/content/default-title.png": "./client/content/default-title.png"
			prod:
				files: [
					{ expand: true, src: ["./config.json", "./package.json", "bower.json", ".bowerrc"], dest: "./dist/web" },
					{ expand: true, src: ["./deploy.cmd", "./.deployment", "./IISNode.yml", "./web.config"], dest: "./dist/web" },
					{ expand: true, src: ["./client/**/*.json"], dest: "./dist/web" },
					{ expand: true, src: ["./views/**/*.jade", "./views/**/*.html"], dest: "./dist/web" },
					{ expand: true, src: ["./client/robots.txt"], dest: "./dist/web" }
				]

		less:
			dev:
				options:
					cleancss: false
				files:
					"./client/style/main.css": "./client/style/main.less"
			prod:
				files:
					"./dist/web/client/style/main.css": "./client/style/main.less"

		nodemon:
			dev:
				script: "index.js"
				options:
					nodeArgs: ["--debug"]
					ignore: ['node_modules/**', 'client/lib/**']

		watch:
			client:
				files: ["./client/**/*.coffee", "./client/**/*.less", "./config.json"]
				tasks: ["client"]
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

	grunt.registerTask 'buildweb', 'Build the project into the dist/web', ["coffee:prod","less:prod","copy:prod"]

	grunt.registerTask 'f5', 'Build, run, and watch application.', ["client","concurrent"]
