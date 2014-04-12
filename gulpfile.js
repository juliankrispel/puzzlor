var gulp = require('gulp'),
    fs = require('fs'),
    gutil = require('gulp-util'),
    coffee = require('gulp-coffee'),
    watch = require('gulp-watch'),
    browserify = require('gulp-browserify'),
    connect = require('gulp-connect'),
    uglify = require('gulp-uglify'),
    plumber = require('gulp-plumber')
    rename = require('gulp-rename');


gulp.task('browserify', function(){
    gulp.src('./src/index.coffee', {read: false})
        .pipe(browserify({
            insertGlobals: true,
            transform: ['coffeeify'],
            extensions: ['.coffee']
        }))
        .on('error', function(e,d){
            console.log('browserify encountered an error: ', e,d);
        })
        .pipe(rename({basename: 'game', extname: '.js'}))
        .pipe(gulp.dest('./dist/'))
        .pipe(connect.reload());
});

gulp.task('connect', function() {
  connect.server({
    root: './',
    port: 6777,
    livereload: true
  });
});

var watcher = gulp.watch('./src/*.coffee', ['browserify']);
gulp.task('watch', function(){
    watcher.on('change', function(event){
        console.log('File '+event.path+' was '+event.type+', running tasks...');
    });
});

gulp.task('default', ['connect', 'watch']);
