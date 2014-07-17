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
    'src/javascripts/**/*.js'],
  stylesheets: [
    'bower_components/bootstrap/dist/css/bootstrap.css',
    'bower_components/font-awesome-bower/css/font-awesome.css',
    'bower_components/codemirror/lib/codemirror.css',
    'src/stylesheets/**/*.css'
  ]
};


gulp.task('process-scripts', function() {
  gulp.src(paths.scripts)
    .pipe(concat('application.js'))
    .pipe(gulp.dest('public/'))
    .pipe(rename({suffix: '.min'}));
});


gulp.task('process-css', function() {
  gulp.src(paths.stylesheets)
    .pipe(concat('application.css'))
    .pipe(gulp.dest('public/stylesheets/'))
    .pipe(rename({suffix: '.min'}));
});




gulp.task('watch', function() {
  gulp.watch([paths.scripts,paths.stylesheets], ['process-scripts', 'process-css']);
});
