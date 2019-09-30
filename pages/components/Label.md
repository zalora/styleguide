 # Label
 
 ```html
<div class="label--general">General</div>
<div class="label--success">Success</div>
<div class="label--alert">Alert</div>
<div class="label--warning">Warning</div>
<div class="label--new">New</div>
 ```

 ## Usage
 
 Use labels to highlight a status through quick recognition. 
 
 |  Label | Color | Usage |
 | :---- |:---- |:---- |
 | <div class="label--general">General</div> | grey | Use for neutral information such as non-returnable, non-exchangeable. |
 | <div class="label--success">Success</div> | green | Use for success feedback like 'available', 'done', 'approved', 'added'. |
 | <div class="label--alert">Alert</div> | red | Use for failure states like 'error', 'decline', 'failed'. |
 | <div class="label--warning">Warning</div> | yellow | Use for warning state. |
 | <div class="label--new">New</div> | teal | Use for temporary labels that need to grab attention, e.g. highligthing a new feature.|
 
 For counts, e.g. 'items in cart', use Badge instead.
 
### Principles
 
 1. Applies our color system
 2. Super short text only


## Anatomy

### Variation

* You can include an icon, provided the icon is simple, useful and has the same height as the font.

![label with icon](img/label/label_with_icon.png "Label with icon")

### Specification

![general spec](img/label/label_spec_general.png "General spec")

* Max length: 192px (of which text is max 184px)
* If text length > 184px, the text will be truncated with an ellipsis. Since there is no way to see the full content beyond the ellipsis, make sure to keep the text shorter than that!

![truncated label](img/label/truncated_label.png "Truncated label")
