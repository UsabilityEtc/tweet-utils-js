module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:
        files:
          'src/index.js': ['src/*.coffee']
          'spec/index_spec.js': ['spec/*.coffee']

    uglify:
      my_target:
        files:
          'index.min.js': 'src/index.js'

    jasmine_nodejs:
      options:
        specNameSuffix: "_spec.js"
        useHelpers: false
        stopOnFailure: true
        verbose: true
        reporters:
          console:
            colors: true
            cleanStack: 1
            verbosity: 4
            listStyle: "indent"
            activity: false
        customReporters: []
      your_target:
          specs: "spec/**"

    watch:
        files: '**/*.coffee'
        tasks: ['test']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-jasmine-nodejs')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('build', ['coffee', 'uglify'])
  grunt.registerTask('test', ['jasmine_nodejs'])
  grunt.registerTask('default', ['build', 'test'])
