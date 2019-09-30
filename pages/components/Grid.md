# Grid

A grid system helps you to build a responsive layout by aligning page elements based on sequenced columns and rows. 

Zalora/Style has a dynamic number of columns. Depends on the size of the screen, we have the grid system has 4 columns, 8 columns or 12 columns.

## Usage
Use the grid system to build consistent layout between pages and maximize the experience for users with a variety of screen sizes. 


## Fluid container, columns, margins and gutters

Zalora/Style adopts fluid-container with a **min-width(320px)** and a **max-width(1344px)** in its grid system. A fluid container is a container that is always expanded to the **full-width** of the screen. But in Zalora/Style, the container won't go smaller than 320px, or larger than 1344px. It helps us to remain consistency layout between devices.

![columns-gutters-margins-figure-caption](img/grid/grid_composition.png)

## Breakpoints

A breakpoint is the range of predetermined screen sizes that have specific layout requirements. At a given breakpoint range, the layout adjusts to suit the screen size and orientation.

The following video is a demonstration from [Material Design](https://material.io/design/layout/responsive-layout-grid.html#) about how breakpoints help to arrange layout on different size of screens.

<video controls autoplay>
<source data-src="https://storage.googleapis.com/spec-host-backup/mio-design%2Fassets%2F1fsdEL9VNAeJaQjU-bdzLZnZ2IuoPEpYT%2Flayout-responsive-breakpoints.mp4" src="https://storage.googleapis.com/spec-host-backup/mio-design%2Fassets%2F1fsdEL9VNAeJaQjU-bdzLZnZ2IuoPEpYT%2Flayout-responsive-breakpoints.mp4" type="video/mp4"/> </video>

Zalora/Style defines 4 breakpoints: small, medium, large and extra large:

| Breakpoint Range | Portrait        | Class prefix    | Column | Margin | Gutter |
|------------------|-----------------|-----------------|--------|--------|--------|
| **< 600px**          | Phone           | col-*, col-sm-* | 4      | 16px   | 8px    |
| **>= 600px**         | Tablet          | col-md-*        | 8      | 16px   | 16px   |
| **>= 1023px**        | Laptop          | col-lg-*        | 12     | 32px   | 16px   |
| **>= 1344px**        | Desktop monitor | col-xl-*        | 12     | -      | 24px   |

By applying the breakpoint, we can adjust the layout of a page into different screen sizes:

![How grid works on different screen sizes](img/grid/grid_on_different_sizes.png)

## Implementation

Zalora/Style's grid system is built with [flexbox](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox). Below are examples and an in-depth look at how the grid comes together.

You may need some background knowledge of flexbox to follow the guidelines below. This [CSS Tricks flexbox guide](https://css-tricks.com/snippets/css/a-guide-to-flexbox/#flexbox-background) is an excellent place for you to get to know the background, terminology, guidelines and code snippets.
### Auto layout
You can fix the width of columns and make the rest columns share the available space evenly. Or you can adjust a column's width based on its content.
#### Equal width

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

#### Setting one column width
In many layouts, you may want to fix the width of one column and have the rest columns automatically resize around it.

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

### Grid with breakpoints

#### All breakpoints
The column widths apply at all breakpoints (i.e. col-`sm`-1 is applied to all screens that are `sm` **and up**).
The class names are formed by col-`{breakpoint}`-`{#columns}`. The number of columns is limited by the breakpoint. I.e. for `sm` you can take maximun `4` cloumns.

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
</section>
```
#### Mix and match
You may also have multiple widths defined. It causes the layout to change at the defined breakpoint. E.g. a column can be defined as `col-sm-4 col-lg-6`=> when the screen is smaller than `lg` the column takes 100% of the row, while when the screen is `lg` and up, the column takes 6/12 (1/2) of the screen.

```html
<section class="container--fluid is-debug">
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

### Alignment
Use flexbox alignment utilities to vertically and horizontally align columns. 

#### Vertical alignment

- Container level
Use utility class `align-items-{start/end/center/baseline/stretch}` to define the alignment along the cross axis for the container.
```html
<section class="container--fluid is-debug">
    <strong>Start</strong>
    <div class="row align-items-start" style="height:100px; background:#D6E6E7;">
        <span class="col">col</span>
        <span class="col">col</span>
        <span class="col">col</span>
    </div>
    <strong>Center</strong>
    <div class="row align-items-center" style="height:100px; background:#D6E6E7;">
        <span class="col">col</span>
        <span class="col">col</span>
        <span class="col">col</span>
    </div>
    <strong>End</strong>
    <div class="row align-items-end" style="height:100px; background:#D6E6E7;">
        <span class="col">col</span>
        <span class="col">col</span>
        <span class="col">col</span>
    </div>
    <strong>Baseline</strong>
    <div class="row align-items-baseline" style="height:100px; background:#D6E6E7">
        <span class="col">col</span>
        <span class="col">col</span>
        <span class="col">col</span>
    </div>
    <strong>Stretch</strong>
    <div class="row align-items-stretch" style="height:100px; background:#D6E6E7;">
        <span class="col">col</span>
        <span class="col">col</span>
        <span class="col">col</span>
    </div>
</section>
```
- Item level
Use utility class `align-self-{start/end/center}` to override the alignment along the cross axis defined to the container.

```html
<section class="container--fluid is-debug">
    <div class="row" style="height:100px; background:#D6E6E7;">
        <span class="col align-self-start">align-self-start</span>
        <span class="col align-self-center">align-self-center</span>
        <span class="col align-self-end">align-self-end</span>
    </div>
</section>
```

#### Horizontal
Use utility class `justify-content-{start/end/center/between/around}` to define the alignment along to main axis (default: horizontal axis)
```html
<section class="container--fluid is-debug">
    <strong>Start</strong>
    <div class="row justify-content-start" style="background:#D6E6E7;">
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
    </div>
    <strong>End</strong>
    <div class="row justify-content-end" style="background:#D6E6E7;">
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
    </div>
    <strong>Center</strong>
    <div class="row justify-content-center" style="background:#D6E6E7;">
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
    </div>
    <strong>Between</strong>
    <div class="row justify-content-between" style="background:#D6E6E7;">
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
    </div>
    <strong>Around</strong>
    <div class="row justify-content-around" style="background:#D6E6E7;">
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
        <span class="col-md-1">col-md-1</span>
    </div>
</section>
```
#### Column wrapping
Within each breakpoint, if the number of columns in a single row exceeds the number of columns defined for the breakpoint, then the extra columns will be wrapped into a new line.

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col-sm-2">col-sm-2</span>
        <span class="col-sm-2">col-sm-2</span>
        <span class="col-sm-2">col-sm-2(new line)</span>
    </div>
</section>
```

### Reordering
#### Order classes
Use `.order-{breakpoint}-{#}` classes for controlling the visual order of your content. There are also classes `.order-{breakpoint}-first` and `.order-{breakpoint}-last` that change the order of an element by applying order: -1 and order: $columns + 1, respectively.

***Note that***, the default order of a column is 0. Thus, in the below example, even the second `<span>` has been given order-sm-2 it is placed at the 3rd place in the preview, as `-1 < 0 < 2 < 5`.

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col order-sm-last">order-sm-last (order = 5)</span>
        <span class="col order-sm-2">2, order-sm-2 (order = 2)</span>
        <span class="col">3 (order = 0)</span>
        <span class="col order-sm-first">4, order-sm-first (order = -1)</span>
    </div>
</section>
```
#### Offset classes
Move columns to the right using `.offset-{breakpoint}-{#}` classes. These classes increase the left margin of a column by # columns. For example, .offset-md-4 moves a column over four columns when the screen is `md` or up.

```html
<section class="container--fluid is-debug">
    <div class="row">
        <span class="col offset-sm-1">1, offset-sm-1</span>
        <span class="col">2</span>
        <span class="col offset-md-1">3, offset-md-1</span>
        <span class="col">4</span>
    </div>
</section>
```

### Nestign 
```html
<section class="container--fluid is-debug">
    <div class="row">
        <div class="col-sm-1">Level 1 <br>When content is longer than the container, it is automatically wrapped into the next line</div>
        <div class="col">
            Level 1
            <div class="row">
                <div class="col">Level 2</div>
                <div class="col offset-md-1">Level 2, offset-md-1</div>
            </div>
        </div>
    </div>
</section>
```