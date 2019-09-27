# Banner
Banners are used to display prominent and important messages. They provide actions which the users are required to address. Users must dismiss banners before they disappear.

## Usage
Banners contain a single message and specific actions for users to take. We use semantic colours to emphasis the type of content.

**Positive** banners are used to convey positive messages.

```html
<div class="banner banner--positive">
  <div class="banner__body">
    Banner for 1 line message and 2 action button.
  </div>
  <div class="banner__actions">
    <button class="banner__actionsItem">Action 1</button>
    <button class="banner__actionsItem">Action 2</button>
  </div>
</div>
```

**Warning** banners appear before users take actions because its intent is to prevent users’ mistakes before the action is done.

```html
<div class="banner banner--warning">
  <div class="banner__body">
    Banner for 1 line message and 2 action button.
  </div>
  <div class="banner__actions">
    <button class="banner__actionsItem">Action 1</button>
    <button class="banner__actionsItem">Action 2</button>
  </div>
</div>
```
**Negative** banners appear after users take actions to inform them of errors.

```html
<div class="banner banner--negative">
  <div class="banner__body">
    Banner for 1 line message and 2 action button.
  </div>
  <div class="banner__actions">
    <button class="banner__actionsItem">Action 1</button>
    <button class="banner__actionsItem">Action 2</button>
  </div>
</div>
```


### Rules
* Banners are interruptive and should be avoided as much as possible.
* Banners are displayed at the top of the screen, below a top app bar. * Banners remain on screen when scrolling pannable content. They are persistent and non modal, allowing users to ignore them or interact with them at any time.
* The information on the banners are always shown in context.

### Frequency
Only one banner is shown at a time. One banner is dismissed by users before another banner shows. Because of this, we should minimise the use of banners to avoid information loss.

### Actions
There should be no more than 2 text buttons in each banner. The action to confirm the action should always be on the right.
Text buttons should always be displayed side by side. Text buttons should **not** have more than 2 words. Only in exceptional cases should text buttons be stacked due to insufficient space.

```html
<div class="row u-margin-top-l">
  <div class="col">
    <div class="banner">
      <div class="banner__body">
        A banner for 1 line message and 1 action button.
      </div>
      <div class="banner__actions">
        <button class="banner__actionsItem">Action</button>
      </div>
    </div>
  </div>
</div>
<div class="row u-margin-top-l">
  <div class="col">
    <div class="banner">
      <div class="banner__body">
        Banner for 1 line message and 2 action button.
      </div>
      <div class="banner__actions">
        <button class="banner__actionsItem">Action 1</button>
        <button class="banner__actionsItem">Action 2</button>
      </div>
    </div>
  </div>
</div>
<div class="row u-margin-top-l">
  <div class="col">
    <div class="banner">
      <div class="banner__body">
        Banner for 2 lines message and 2 action button. The maximum length is 2 lines.
        Banner for 2 lines message and 2 action button. The maximum length is 2 lines.
      </div>
      <div class="banner__actions">
        <button class="banner__actionsItem">Action 1</button>
        <button class="banner__actionsItem">Action 2</button>
      </div>
    </div>
  </div>
</div>
```

## Related components

* [Popup](/#/components/Popup)
* [Toastr](/#/components/Toastr)