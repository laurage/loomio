# writes dist/javascripts/app(.min).js
paths    = require './paths'
gulp     = require 'gulp'
pipe     = require 'gulp-pipe'
append   = require 'add-stream'
coffee   = require 'gulp-coffee'
concat   = require 'gulp-concat'
uglify   = require 'gulp-uglify'
rename   = require 'gulp-rename'
expect   = require 'gulp-expect-file'

module.exports =
  fonts: ->
    pipe gulp.src(paths.extra.fonts), [
      gulp.dest(paths.dist.fonts) # write public/fonts/*
    ]

  emoji: ->
    pipe gulp.src(paths.extra.emojis), [
      gulp.dest(paths.dist.emojis) # write public/img/emoji
    ]

  moment_locales: ->
    pipe gulp.src(paths.extra.moment_locales), [
      gulp.dest(paths.dist.moment_locales) # write public/client/moment_locales
    ]

  execjs:
    development: ->
      pipe gulp.src(paths.js.execjs), [
        expect({errorOnFailure: true}, paths.js.execjs),
        append.obj(pipe gulp.src(paths.js.execcoffee), [coffee(bare: true)])
        concat('execjs.js'),
        gulp.dest(paths.dist.assets)
      ]

    production: ->
      pipe gulp.src(paths.js.execjs), [
        expect({errorOnFailure: true}, paths.js.execjs),
        append.obj(pipe gulp.src(paths.js.execcoffee), [coffee(bare: true)])
        concat('execjs.min.js'),
        uglify(mangle: false),
        gulp.dest(paths.dist.assets)
      ]
