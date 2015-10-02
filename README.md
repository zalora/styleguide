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

### Global SCSS Submodule

This project includes two submodules:

- [Global scss](https://github.com/zalora/global-scss)
- [Mobile scss](https://github.com/zalora/mobile-scss)

Clone the repo with the `recursive` flag to also get the contents of the submodules, like this:

`git clone --recursive git@github.com:zalora/styleguide.git`

To update the submodules later run:

`git submodule foreach git pull origin master`

For further reading on submodules: [Git-Tools-Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)


### Gulp

We use Gulp to run Hologram, Sass compilation and Jekyll rebuild. Browser Sync refreshes your Sass changes directly in the browser without reloading. Yaay! BONUS: Try connection to your local server with more than one browser, and navigation the page ;)

Install npm packages with: ```npm install```

Then run ```gulp``` to start developing. That will fire up a local web server and wait for you to edit any .html, .js, .md, .scss file.


#### Deploying to Github pages

To deploy the site, make a pull request to ```master``` and watch Bamboo do magic!
We love PRs, please fork this repo and do a PR if there is something you need to change.

from the root of the project and the compiled jekyll site will be pushed to the `gh-pages` branch and with this updated on the web.

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

#### Images and other assets

All assets like **images** to display in the site live in:

```
- src/
  - assets/
    - images/
      - content/
```

Please put your content in sub directory according to the navigation structure in which your page is gonna live in.

Assets like **ZIP files** for **downloading** go into:

```
- src/
  - assets/
    - downloads/
```

### Global styles

All the files in

```
- src/
  - assets/
    - scss/
      - global/
```

are actually another git repository included into this one as a **submodule**. The [global scss](https://github.com/zalora/global-scss) repo hold all the basic styling for web projects at ZALORA. This, for example, is included in the ZALORA shop.

Pages on the styleguide are automatically generated out of code comments in the `.scss` files themselves.

A comment looks like this: [_buttons.scss](https://github.com/zalora/global-scss/blob/master/components/_buttons.scss)


