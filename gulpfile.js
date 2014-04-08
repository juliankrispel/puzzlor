var gulp = require('gulp'),
    fs = require('fs'),
    gutil = require('gulp-util'),
    coffee = require('gulp-coffee'),
    watch = require('gulp-watch'),
    browserify = require('gulp-browserify'),
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
        .pipe(gulp.dest('./dist/'));
});

gulp.task('buildSrc', function () {
    gulp.src('./src/*.coffee')
        .pipe(plumber())
        .pipe(coffee({bare: true}))
        .on('error', gutil.log)
        .on('error', gutil.beep)
        .pipe(rename({extname: '.js'}))
        .pipe(gulp.dest('./dist/'))
        .pipe(uglify())
        .pipe(rename({suffix: '.min'}))
        .pipe(gulp.dest('./dist/'));
});

var watcher = gulp.watch('./src/*.coffee', ['browserify']);
gulp.task('default', function(){
    watcher.on('change', function(event){
        console.log('File '+event.path+' was '+event.type+', running tasks...');
    });
});
