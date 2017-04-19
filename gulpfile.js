"use strict";

var gulp = require("gulp"),
    del = require("del"),
    browserSync = require("browser-sync"),
    // This auto requires all gulp (!) packages listed in package.json
    // Use with $.pluginname
    $ = require("gulp-load-plugins")();

/**
 * Compiles Sass files and outputs them into the CSS dir.
 */

gulp.task("sass", function () {
  return gulp.src("src/assets/_scss/**/*.scss")
    .pipe($.sass({outputStyle: 'compressed'}).on('error', $.sass.logError))
    // Directory your CSS file goes to
    .pipe(gulp.dest("src/assets/css"))
    .pipe(gulp.dest("dist/assets/css"))
    // Outputs the size of the CSS file
    .pipe($.size({title: "css"}))
    // Injects the CSS changes to your browser since Jekyll doesn"t rebuild the CSS
    .pipe(browserSync.reload({stream: true}));;
});

/**
 * Hologram
 *
 * this generates the html files from code comments
 */

gulp.task("clean:hologram", del.bind(null, ["src/components/**/*"]));

gulp.task("hologram-rebuild", ["clean:hologram"], function() {
  // Grabs all Hologram config files and
  // executes Hologram for each of them
  return gulp.src('hologram_*.yml', { read: false })
    .pipe($.shell('bundle exec hologram <%= file.path %>'));
});


/**
 * Jekyll
 */

// This will build the site with the production settings
gulp.task("jekyll:prod", ["hologram-rebuild"], $.shell.task("bundle exec jekyll build --config _config.yml,_config.build.yml"));

// Runs the build command for Jekyll to compile the site locally
gulp.task("jekyll:dev", $.shell.task("bundel exec jekyll build"));
gulp.task("jekyll-rebuild", ["jekyll:dev"], function () {
  browserSync.reload();
});


// Runs the build command for Jekyll,
// but waits for hologram to finish
gulp.task("jekyll:dev-hologram", ["hologram-rebuild"], $.shell.task("bundle exec jekyll build"));
gulp.task("hologram-jekyll-rebuild", ["jekyll:dev-hologram"], function() {
  browserSync.reload();
});


/**
 * Watch
 *
 * These tasks will look for files that change while serving and
 * will auto-regenerate or reload the website accordingly.
 * Update or add other files you need to be watched.
 */

gulp.task("watch", function () {
  // just run sass task for local files
  gulp.watch(["src/assets/_scss/local/**/*.scss"], ["sass"]);

  // run hologram rebuild for files that contain documentation
  gulp.watch([
    "src/assets/_scss/onsite/**/*.scss",
    "src/assets/_scss/global/**/*.scss",
    "src/assets/_scss/mobile/**/*.scss"
  ], ["sass", "hologram-jekyll-rebuild"]);

  gulp.watch([
    "src/**/*.js",
    "src/**/*.md",
    "src/**/*.html",
    "!src/components/**/*.html", // Exclude this, because jekyll-rebuild gets triggered by "hologram-jekyll-rebuild" above
    "src/**/*.xml",
    "src/**/*.txt"
  ], ["jekyll-rebuild"]);
});

/**
 * Server
 *
 * BrowserSync will serve our site on a local server for us and
 * other devices to use.
 * It will also autoreload across all devices as well as keep
 * the viewport synchronized between them.
 */

gulp.task("serve:dev", ["sass", "jekyll:dev-hologram"], function () {
  browserSync({
    notify: true,
    // tunnel: "",
    browser: "google chrome",
    server: {
      baseDir: "dist"
    }
  });
});


/**
 * Workflows to run on CLI
 *
 * NOTE: you can run the other gulp tasks defined above individually
 * but this is not intended. Use these bundled ones to make sure
 * stuff happens in the correct order.
 */

// Run this to start development on the styleguide
gulp.task("default", ["serve:dev", "watch"]);

gulp.task("build", ["sass", "jekyll:prod"]);

gulp.task('deploy', ['build'], function() {
  return gulp.src('./dist/**/*')
    .pipe($.ghPages());
});

gulp.task('ci_deploy', ['deploy'], function() {
    process.exit(0);
});
