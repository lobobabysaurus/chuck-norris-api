module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-mocha-test')

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
        options:
          reporter: 'nyan'
          timeout: 10000
        src: ['test/**/*.coffee']

  grunt.registerTask('default', ['mochaTest', 'coffeelint', 'coffee'])
