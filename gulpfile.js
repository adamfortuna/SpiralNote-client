var gulp = require('gulp'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat'),
    uglify = require('gulp-uglify');

var paths = {
  scripts: [
    'bower_components/EventEmitter2/lib/eventemitter2.js',
    'bower_components/lodash/dist/lodash.js',
    'bower_components/angular/angular.js',
    'bower_components/angular/angular.js',
    'bower_components/angular-route/angular-route.js',
    'bower_components/angular-event-emitter/angular-event-emitter.js',
    'bower_components/firebase/firebase.js',
    'bower_components/angularfire/angularfire.js',
    'bower_components/codemirror/lib/codemirror.js',
    'bower_components/codemirror/mode/xml/xml.js',
    'bower_components/codemirror/mode/javascript/javascript.js',
    'bower_components/codemirror/mode/css/css.js',
    'bower_components/codemirror/mode/htmlmixed/htmlmixed.js',
    'src/javascripts/**/*.js']
};


gulp.task('process-scripts', function() {
  gulp.src(paths.scripts)
    .pipe(concat('application.js'))
    // .pipe(uglify())
    .pipe(gulp.dest('public/'))
    .pipe(rename({suffix: '.min'}));
});



gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['process-scripts']);
});
