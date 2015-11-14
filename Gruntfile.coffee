module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-uglify')
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
        src: ['test/**/*.coffee']
    uglify:
      my_target:
        files:
          'dist/index.min.js': ['dist/index.js']

  grunt.registerTask('default', ['mochaTest', 'coffeelint', 'coffee', 'uglify'])
