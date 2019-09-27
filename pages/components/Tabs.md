# Tabs
Tabs are used to organise and allow navigation between groups of content that are related and at the same level of hierarchy.

In contrast, the content in navigation bars are unrelated to each other.


## Usage
<span class="u-text-positive">Do</span>
* Tabs are used for mobile design.
* They are placed above the content it represents and below the top bar.
* There can be as many tabs as required.
* Pre-select one of the tabs (usually the first) when user lands.
* Active tab must be highlighted.

<span class="u-text-urgent">Don't</span>
* Put icon in tabs.
* Put more than 2 words.
* Stack tabs.
* Place tabs above unrelated content that they do not control. 

![usage of tabs](img/tabs/tabs_usage.png "Do[The tabs in this page control the category list below it.]")


![wrong usage of tabs](img/tabs/tabs_wrong_usage.png "Don't[Tab elements should only be used for tabs.]")


## Type

#### Fixed tabs

All the tabs are shown on one screen. All tabs have the same width. E.g. “New customer” and “Returning customer” tabs on the Sign up/Log in page.

```html
<div class="row">
  <div class="col">
    <div class="tab tab--equal" id="equal-size-tabs">
      <ul class="tab__list">
        <li class="tab__listItem is-active">Item 1 (Active)</li>
        <li class="tab__listItem">Item 2</li>
      </ul>
    </div>
  </div>
</div>
```

#### Scrollable tabs

Some tabs are off-screen until users scroll horizontally. Best to show “cut off” words to inform users that they can scroll further. Scrollable tabs do not require to be of the same width.

```html
<div class="row">
  <div class="col-sm-1">
    <div class="tab">
      <ul class="tab__list">
        <li class="tab__listItem is-active">Item 1 (Active)</li>
        <li class="tab__listItem">Item 2</li>
        <li class="tab__listItem">Item 3</li>
        <li class="tab__listItem">Item 3</li>
        <li class="tab__listItem">Item 3</li>
        <li class="tab__listItem">Item 3</li>
      </ul>
    </div>
  </div>
</div>
```

### Actions
Moving between tabs
- Tap a tab (all platform)
- Swipe within the content area (iOS and android)

Scrolling interaction of tabs
- When a screen scrolls, tabs can either be fixed to the top of the screen, or scroll off the screen. If they scroll off the screen, they will return when the user scrolls upward.
- Don’t scroll tabs behind a top app bar. When tabs are attached to a component, they should appear and move as a single unit.
