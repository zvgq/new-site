module.exports = function (grunt) {
	// initialize
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		// grunt-babel
		babel: {
			dev: {
				expand: true,
				cwd: './',
				src: ['**/*.js','!gruntfile.js','!test/**/*.*','!client/lib/**/*.*','!node_modules/**/*.*'],
				dest: './dist',
				ext: '.js'
			}
		},

		// grunt-contrib-clean
		clean: {
			all: {
				options: {
					force: true
				},
				src: ['./dist/**']
			}
		},

		// grunt-contrib-coffee -- Should go away after all files are converted
		coffee: {
			dev: {
				files: {
					'./dist/routers/wwwrouter.js': './routers/wwwrouter.coffee'
				}
			}
		},

		// grunt-contrib-copy
		copy: {
			config: {
				files: {
					'./dist/IISNode.yml':'./IISNode.yml',
					'./dist/web.config':'./web.config',
					'./dist/deploy.cmd':'./deploy.cmd',
					'./dist/.deployment':'./.deployment',
					'./dist/.bowerrc':'./.bowerrc',
					'./dist/package.json': 'package.json',
					'./dist/bower.json': 'bower.json'
				}
			},
			client: {
				expand: true,
				cwd: './client',
				src: ['images/*','robots.txt'],
				dest: './dist/client'
			},
			lib: {
				expand: true,
				cwd: './client/lib',
				src: '**/*',
				dest: './dist/client/lib'
			},
			views: {
				expand: true,
				cwd: './views',
				src: ['**/*.*'],
				dest: './dist/views'
			},
			dev: {
				files: {
					'./dist/config.dev.json': './config.dev.json'
				}
			}
		},

		// grunt-contrib-less
		less: {
			dev: {
				options: {
					cleancss: true
				},
				files: {
					"./dist/client/style/main.css": "./client/style/main.less"
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
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-mocha-phantomjs');

	// project tasks
	grunt.registerTask('default','Runs the dev build process', ['dev']);

	grunt.registerTask('dev', 'Build and Test for local development',
		['clean:all',
			'babel:dev',
			'coffee:dev',
			'copy:dev', 'copy:config', 'copy:client', 'copy:views',
			'less:dev',
			'mocha_phantomjs:client'
		]);
};
