module.exports = (grunt) ->
  grunt.initConfig {
    pkg: grunt.file.readJSON 'package.json'
    i18n:
      src: ['l10n-templates/**/*']
      options:
        locales: 'translations/*.yaml'
        output: '.tmp/l10n'
        base: 'l10n-templates'

    useminPrepare:
      html: 'l10n-templates/**/*.html'
      options:
        root: '.tmp/app'
        dest: 'dist'

    usemin:
      html: '.tmp/l10n/**/*.html'

    watch:
      i18n:
        files: ['l10n-templates/**/*', 'translations/**/*']
        tasks: ['i18n', 'copy:i18nTmp']

      livescript:
        files: ['app/**/*.ls']
        tasks: ['livescript', 'commonjs', 'copy:jsTmp']

      stylus:
        files: ['app/**/*.styl']
        tasks: ['stylus', 'autoprefixer', 'copy:cssTmp']

    connect:
      server:
        options:
          base: ['app/bower_components', '.tmp/app']

    livescript:
      options:
        bare: true

      compile:
        expand: true
        cwd: 'app'
        src: [ '**/*.ls' ]
        dest: '.tmp/lsc'
        ext: '.js'

    commonjs:
      modules:
        cwd: '.tmp/lsc/scripts'
        src: [ '**/*.js' ]
        dest: '.tmp/commonjs/'

    stylus:
      options:
        compress: false
        linenos: true
        urlfunc: 'embedurl'

      compile:
        expand: true
        cwd: 'app'
        src: [ 'styles/index.styl' ]
        dest: '.tmp/styl'
        ext: '.css'

    autoprefixer:
      main:
        src: '.tmp/styl/**/*.css'

    cssmin:
      options:
        report: 'gzip'

    copy:
      l10nMain:
        expand: true
        cwd: '.tmp/l10n'
        src: ['**/*']
        dest: 'dist'

      l10nDefault:
        expand: true
        cwd: '.tmp/l10n/en'
        src: ['**/*']
        dest: 'dist'

      jsTmp:
        expand: true
        cwd: '.tmp/commonjs'
        src: ['**/*']
        dest: '.tmp/app/scripts'

      cssTmp:
        expand: true
        cwd: '.tmp/styl'
        src: ['**/*']
        dest: '.tmp/app/'

      i18nTmp:
        expand: true
        cwd: '.tmp/l10n/'
        src: ['**/*']
        dest: '.tmp/app'

      bowerTmp:
        src: 'app/bower_components/**/*'
        dest: '.tmp/'

    clean:
      build: ['.tmp', 'dist']
      tmp: ['.tmp']
  }

  grunt.registerTask 'prepare', ['clean:build', 'useminPrepare']
  grunt.registerTask 'compile', ['i18n', 'livescript', 'commonjs', 'stylus', 'autoprefixer']
  grunt.registerTask 'copyTmp', ['copy:jsTmp', 'copy:cssTmp', 'copy:i18nTmp', 'copy:bowerTmp']
  grunt.registerTask 'optimize', ['usemin', 'concat', 'uglify', 'cssmin', 'copy:l10nMain', 'copy:l10nDefault']
  grunt.registerTask 'default', ['prepare', 'compile', 'copyTmp', 'optimize']

  grunt.registerTask 'server', ['clean', 'compile', 'copyTmp', 'connect:server', 'watch']

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-livescript'
  grunt.loadNpmTasks 'grunt-commonjs'
  grunt.loadNpmTasks 'grunt-usemin'
  grunt.loadNpmTasks 'grunt-i18n'
