# Tooltip

Tooltips display informative text when users hover over, focus on, or tap an element.

Insert component -- added by developer

## Usage
When activated, tooltips display a text label identifying an element, such as a description of its function.


### Principles

1. **Activated** (if it is meant to be permanent information, refer to Label).
2. **Paired** with the element it describes
3. **Short** text only (for longer messages, refer to Pop Up)


## Anatomy

Insert image.


| `Do`        | `Don't`           |
| ------------- |-------------|
| * Read-only text | * Use buttons or links |
| |* Use tooltips to restate visible UI text. |
| |* Communicate information that is critical for the user - they might miss it |
| |* Crop them accidentally on the edges |
| |* Place them interfering with what the user is doing right-aligned |


### Activation

Desktop - Tooltip is actived on hover

Mobile - Tooltip displayed through long press

Android - Tooltip may be summoned through focus

iOS - Tooltip may be actived by force touch (consider this is very hidden)

### Timing

Display the tooltip for 1.5 seconds. If the user takes another action before that time ends, the tooltip will disappear.

### Motion

Over 150ms, tooltips fade in and scale up using the deceleration curve. Fades out over 75ms.


## Variations

* With or without closing element.

* With or without icon, e.g. (i)


## Placement 

The position of the tooltip is flexible and will change depending on how close the elemeent is to the edge of the screen.

## Implementation 

```html
<div id="tooltip-top" class="btn btn--primary" data-title="Tooltip on the top" data-placement="top">Top</div>
<div id="tooltip-right" class="btn btn--primary" data-title="Tooltip on the right" data-placement="right">Right</div>
<div id="tooltip-bottom" class="btn btn--primary" data-title="Tooltip on the bottom" data-placement="bottom">Bottom</div>
<div id="tooltip-left" class="btn btn--primary" data-title="Tooltip on the left" data-placement="left">Left</div>
```

## Demo 

Added by developer
