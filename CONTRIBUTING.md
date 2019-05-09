# Contributing to Styleguide

## Table of contents
- [Project Structure](#project-structure)
- [Writing Markdown](#writing-markdown)
- [Template of component guideline](#template-of-component-guideline)
- [Development Flow](#development-flow)

## Project Structure
The basic repo layout includes:
* `├── pages/` – the folder that contains individual element/component<br>
  `│   ├── components/` – the guidelines related to individual components<br>
  `│   ├── guides/` - the design principles <br>
* `├── img/` - images used by guideline articles <br>
* `└── src/` – the source code for building the website <br>
* `├── package.json` – the top-level "project" package that contains
  the dependencies and scripts needed to manage the repo <br>
* `├── assets/` <br>

## Writing Markdown

You can copy the [template](#template-of-component-guideline) below to start your guideline of a component.

The template is in markdown format. Not familiar with markdown? No worries, here is the [cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

### Adding image to your markdown file
Adding image to your markdown file, may not be that straitforward if the image you want to include does not has an url. We also believe it's better that you add the images in styleguide repository. So that the project has the full control of it's assets. 

You can add an image to your markdown file by the following steps:
1. Add the image to `img` folder
2. Add `![alt text](./img/path/to/your/image "title text")` to your markdown

E.g. To add `fb.png` in `img/Button` folder, the markdown string will be `![Facebook button](./img/Button/fb.png "Continue with Facebook")`

### Emoji
Feel free to add emoji to your markdown :)
You can just copy the emoji you like and paste to your markdown file. *Noted that: different operating system may have different set of emoji. To deliver the best experience to all of our audiences, please only use common emoji in your file.*




## Template of component guideline
```
# <component name>
Describe what the component is and when it is used. Keep it short.

<insert component> -- added by developer

### Usage
Describe use cases and when not to use the component
Ref to *related component* (if applicable)
Include design *principles* (if applicable)

### Anatomy
<image shows the composition of the component with annotations> 
Ref [Banners - Material Design](https://material.io/design/components/banners.html#anatomy)
list of the anatomies

Breakdown of anatomies 
(Describe every part in detail, e.g. definition, usage, principle)
Noted that: for component containing text, we should always have a section talk about the writing (e.g. length restriction and tone)

### List the variation of the component (if applicable)

### (Optional) Placement 
Describe where the component should be placed

### (Optional) Order and alignment

### Implementation -- added by developer
### Demo -- added by developer
```

## Development Flow
* Create a new topic branch with the name of the component and date, e.g. `button-09052019`

* Create the markdown file in `pages` folder and add images to `img` if it is required.

* Push your branch to github

* Open a Pull Request and descrip what has been done in the PR

* Request review
