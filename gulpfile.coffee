gulp = require 'gulp'
coffee = require 'gulp-coffee'
webserver = require 'gulp-webserver'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'

gulp.task 'default', [
  'coffee'
  'webserver'
  'watch'
]

# webサーバーの起動
gulp.task 'webserver', ->
  gulp.src 'docs'
    .pipe webserver
      livereload: true

# coffeeファイルに変更があった場合に再コンパイルする
gulp.task 'watch', ->
  gulp.watch 'src/**/*.coffee', ['coffee']

# .coffeeのコンパイル
gulp.task 'coffee', ->
  gulp.src([
    'src/extension/string.coffee'
    'src/setting.coffee'
    'src/turn.coffee'
    'src/board.coffee'
    'src/AI/AI.coffee'
    'src/AI/AI1.coffee'
    'src/AI/AI2.coffee'
    'src/AI/AI3.coffee'
    'src/AI/AI4.coffee'
    'src/AI/AI5.coffee'
    'src/AI/AI6.coffee'
    'src/AI/AI7.coffee'
    'src/index.coffee'
  ]).pipe coffee
    bare: true
  .pipe concat('index.js')
  .pipe uglify()
  .pipe gulp.dest 'docs/js/'