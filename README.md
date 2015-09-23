[![Build Status](https://travis-ci.org/zalora/styleguide.svg)](https://travis-ci.org/zalora/styleguide)

# ZALORA Style Guide

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

## Maintaining Content

Ok so there's basically two parts to this website:

1. The Jekyll site which generates html pages from Markdown files.
2. CSS/Sass documentation that is automatically generated through a gem called 'Hologram'

### Pages in Jekyll

To add or change pages navigate to `src` directory and look for a file ending in `.md` or ` .html` in the sub directories. For example the page [Logo](http://styleguide.zalora.com/design/logo.html) exists here:

```
- src/
  - design/
    - logo.md
```

Update that file and get someone (i.e. Winn) to redeploy the site.

### Global styles

