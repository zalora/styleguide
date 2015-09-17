[![Build Status](https://travis-ci.org/zalora/styleguide.svg)](https://travis-ci.org/zalora/styleguide)

ZALORA Style Guide
===========================

This is the ZALORA styleguide project. It collects and showcases everything design related to ensure brand consistency throughout the company

## Tech

This project uses Jekyll, Gulp, Sass and [Hologram](https://github.com/trulia/hologram)

## Installation

### Jekyll

Jekyll is a static site generator written in ruby and we included a `Gemfile` to keep packages in order.

This gets you up and running: ```bundle install```

*If you don't have bundler installed, run:* ```gem install bundler``` first.

### Gulp

We use Gulp to run Hologram, Sass compilation and Jekyll rebuild. Browser Sync refreshes your Sass changes directly in the browser without reloading. Yaay! BONUS: Try connection to your local server with more than one browser, and navigation the page ;)

Install npm packages with: ```npm install```

Then run ```gulp``` to start developing. That will fire up a local web server and wait for you to edit any .html, .js, .md, .scss file.
