# Badge

 Badge is a component to draw attention to another interface element like icons, text and buttons and contains a dynamic count.

 There are two types of badges:
* Badge

```html
<div class="row">
  <div class="col">
    <div class="badge">
      <div class="badge__noCount"></div>
      <span class="badge__content" style="display:inline-block;width:30px;height:30px;background:lightgray;"></span>
    </div>
  </div>
</div>
```

* Badge with a number

```html
<div class="row">
  <div class="col">
    <div class="badge">
      <div class="badge__count">4</div>
      <span class="badge__content" style="display:inline-block;width:30px;height:30px;background:lightgray;"></span>
    </div>
  </div>
  <div class="col">
    <div class="badge">
      <div class="badge__count">999</div>
      <span class="badge__content" style="display:inline-block;width:30px;height:30px;background:lightgray;"></span>
    </div>
  </div>
</div>
```

***Note that***, when the target of the badge is text, you may want to add additional margin to it. This helps you to adjust the position of the badge.

## Usage

Badge is always used with another UI component and not on its own.

They only contain numeric value not text.

Use a circle for showing single digit and capsule for double or more digits.


![Number badge usage](img/badge/badge_usage_number.png "Use number badge, so that it gives feedback to audience about the change of the target of the badge. E.g. Use number badge for wishlist so that the number changes when user add/remove product from wishlist.")


![Circle badge usage](img/badge/badge_usage_dot.png "Use dot badge, when you want to indicate the target of the badge is not in the the default state. E.g. Use dot badge for filter so that user knows that the filter is appplied to current catalog page.")



## Anatomy

Badge is composed of two elements:
* Circle
* Number

Breakdown of anatomies 

1. The badge is placed upper right or above after on the component.

2. Circle diameter is 16 px. 

3. Length of capsule is [number + 8 px] (4 px buffer on both sides), height is 16 px and corner radius is 8 px.

4. Font size is 12 px.

5. It is always in TEAL-60 (#297E84) with numbers in white.

