module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:
        files:
          'index.js': ['src/*.coffee']
          'spec/index_spec.js': ['spec/*.coffee']

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

  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-jasmine-nodejs')

  grunt.registerTask('build', ['coffee'])
  grunt.registerTask('test', ['jasmine_nodejs'])
  grunt.registerTask('default', ['build', 'test'])
