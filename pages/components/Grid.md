# Grid
A grid system helps you to build a responsive layout by aligning page elements based on sequenced columns and rows. 

Zalora/Style has a dynamic number of columns. Depends on the size of the screen, we have the grid system has 4 columns, 8 columns or 12 columns.

## Usage
Use the grid system to build consistent layout between pages and maximize the experience for users with a variety of screen sizes. 


## Fluid container, columns, margins and gutters

Zalora/Style adopts fluid-container with a **min-width(320px)** and a **max-width(1344px)** in its grid system. A fluid container is a container that is always expanded to the **full-width** of the screen. But in Zalora/Style, the container won't go smaller than 320px, or larger than 1344px. It helps us to remain consistency layout between divices.

![columns-gutters-margins-figure-caption](./img/Grid/grid_composition.png "Figure with captions of columns, gutters, margins and fluid container")

## Breakpoints

A breakpoint is the range of predetermined screen sizes that have specific layout requirements. At a given breakpoint range, the layout adjusts to suit the screen size and orientation.

The following video is a demonstration from [Material Design](https://material.io/design/layout/responsive-layout-grid.html#) about how breakpoints help to arrange layout on diffent size of screens.

<video controls autoplay>
<source data-src="https://storage.googleapis.com/spec-host-backup/mio-design%2Fassets%2F1fsdEL9VNAeJaQjU-bdzLZnZ2IuoPEpYT%2Flayout-responsive-breakpoints.mp4" src="https://storage.googleapis.com/spec-host-backup/mio-design%2Fassets%2F1fsdEL9VNAeJaQjU-bdzLZnZ2IuoPEpYT%2Flayout-responsive-breakpoints.mp4" type="video/mp4"/> </video>

Zalora/Style defines 4 breakpoints: small, medium, large and extra large:

| Breakpoint Range | Portrait        | Class prefix    | Column | Margin | Gutter |
|------------------|-----------------|-----------------|--------|--------|--------|
| **< 600px**          | Phone           | col-*, col-sm-* | 4      | 16px   | 8px    |
| **>= 600px**         | Tablet          | col-md-*        | 8      | 16px   | 16px   |
| **>= 1023px**        | Laptop          | col-lg-*        | 12     | 32px   | 16px   |
| **>= 1344px**        | Desktop monitor | col-xl-*        | 12     | -      | 24px   |

By applying the breakpoint, we can adjust the layout of a page into diffent screen sizes:

![How grid works on different screen sizes](./img/Grid/grid_on_different_sizes.png "How grid works on different screen sizes")

## Implementation

Zalora/Style's grid system is built with [flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox). Below is an example and an in-depth look at how the grid comes together.

You may need some background knowledge of flexbox to follow the guidelines below. This [CSS Tricks flexbox guide](https://css-tricks.com/snippets/css/a-guide-to-flexbox/#flexbox-background) is a good place for you to get know the background, terminology, guidelines and code snippets.

### Equal width

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col">
            col
        </span>
        <span class="col">
            col
        </span>
        <span class="col">
            col
        </span>
    </div>
    <div class="row">
        <span class="col">
            col
        </span>
        <span class="col">
            col
        </span>
    </div>
</section>
```

#### Break into multiple lines
There is a util class `w-100` for you to break equal-width columns into multiple lines

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col">
            col
        </span>
        <span class="col">
            col
        </span>
        <span class="w-100"></span>
        <span class="col">
            col
        </span>
        <span class="col">
            col
        </span>
    </div>
</section>
```

### Grid with breakpoints
The column widths apply at all breapoints (i.e. col-`sm`-1 is applied to all screens that is `sm` and up).
You may also have multiple width defined. It causes the layout to change at the defined breakpoint. E.g. a column can be defined as `col-sm-4 col-lg-6`=> when the screen is smaller than `lg` the column takes 100% of the row, while when the screen is `lg` and up, the column takes 6/12 (1/2) of the screen.

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col-md">
            col-md
        </span>
        <span class="col-md">
            col-md
        </span>
        <span class="col-md">
            col-md
        </span>
    </div>
    <div class="row">
        <span class="col-sm-1">
            col-sm-1
        </span>
        <span class="col-sm-1">
            col-sm-1
        </span>
        <span class="col-sm-1">
            col-sm-1
        </span>
        <span class="col-sm-1">
            col-sm-1
        </span>
    </div>
    <div class="row">
        <span class="col-sm-4 col-lg-6">
            col-sm-4 col-lg-6
        </span>
        <span class="col-sm-4 col-lg-6">
            col-sm-4 col-lg-6
        </span>
    </div>
</section>
```
### Auto layout
You can fix the width of columns and make the rest columns share the available space evenly. Or you can adjust a column's width based on its content.

#### Setting one column width
In many layouts you may want to fix the width of one column and have the rest columns automatically resize around it.

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col">
            col
        </span>
        <span class="col-sm-2">
            col-sm-2 (take 50% of the row for sm or up)
        </span>
        <span class="col">
            col
        </span>
    </div>
    <div class="row">
        <span class="col">
            col
        </span>
        <span class="col-lg-4">
            col-lg-4 (take 33% of the row for lg or up)
        </span>
        <span class="col">
            col
        </span>
    </div>
</section>
```

#### Variable width content
Use `col-{breakpoint}-auto` to make the column's width based on the natural width of their content.

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col-sm-1">
            col-sm-1
        </span>
        <span class="col-sm-auto">
            col-md-auto
        </span>
        <span class="col-sm-1">
            col-sm-1
        </span>
    </div>
    <div class="row">
        <span class="col">
            col
        </span>
        <span class="col-sm-auto">
            col-sm-auto
        </span>
        <span class="col">
            col
        </span>
    </div>
</section>
```





## Demo