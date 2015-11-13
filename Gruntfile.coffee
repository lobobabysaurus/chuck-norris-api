module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      app:
        src: ['src/*.coffee']
        dest: 'dist/index.js'
    coffeelint:
      app: ['src/*.coffee']
    mochaTest:
      test:
        src: ['test/**/*.coffee']

  # Coffee Converter
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-mocha-test')

  # Build JS
  grunt.registerTask('default', ['mochaTest', 'coffeelint', 'coffee'])
