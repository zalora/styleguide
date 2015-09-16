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
    .pipe($.sass({
      errLogToConsole: true
    }))
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
 * this generates the html files from the
 * comments inside the global .scss files
 */

gulp.task("clean:hologram", del.bind(null, ["src/docs/**/*"]));
gulp.task("hologram", ["clean:hologram"], $.shell.task("hologram"));


/**
 * Jekyll
 */

// Runs the build command for Jekyll to compile the site locally
gulp.task("jekyll:dev", $.shell.task("jekyll build"));
// This will build the site with the production settings
gulp.task("jekyll:prod", $.shell.task("jekyll build --config _config.yml,_config.build.yml"));

gulp.task("jekyll-rebuild", ["jekyll:dev"], function () {
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
  gulp.watch([
    "src/**/*.md",
    "src/**/*.html",
    "src/**/*.xml",
    "src/**/*.txt",
    "src/**/*.js"
  ], ["jekyll-rebuild"]);

  gulp.watch(["src/assets/_scss/global/**/*.scss"], ["hologram", "sass"]);
  // also run hologram rebuild for global sass files
  gulp.watch(["src/assets/_scss/local/**/*.scss"], ["sass"]);
});

/**
 * Server
 *
 * BrowserSync will serve our site on a local server for us and
 * other devices to use.
 * It will also autoreload across all devices as well as keep
 * the viewport synchronized between them.
 */

gulp.task("serve:dev", ["sass", "jekyll:dev"], function () {
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
