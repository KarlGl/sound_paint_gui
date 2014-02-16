var gulp = require('gulp');
var concat = require('gulp-concat');
var browserify = require('gulp-browserify');
var paths = {
    scripts: ['./client*.js'],
    main: ['./client_main.js'],
};

gulp.task('scripts', function() {
    // console.log("running scripts 2")
    return gulp.src(paths.main)
        .pipe(browserify({
            insertGlobals: true,
            debug: true
        }))
        .pipe(gulp.dest('./dist'));
});

// Rerun the task when a file changes
gulp.task('watch', function() {
    // console.log("running watch")
    gulp.watch(paths.scripts.concat('./gulpfile.js'), ['scripts']);
});

gulp.task('default', ['watch']);
