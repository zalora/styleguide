 # Label
 
 ## Usage
 
 Use labels to highlight a status through quick recognition. 
 
 |  Label | Color | Usage |
 | :---- |:---- |:---- |
 | [Insert label 'General'] | grey | Use for neutral information such as non-returnable, non-exchangeable. |
 | [Insert label 'Success'] | green | Use for success feedback like 'available', 'done', 'approved', 'added'. |
 | [Insert label 'Alert'] | red | Use for failure states like 'error', 'decline', 'failed'. |
 | [Insert label 'Warning'] | yellow | Use for warning state. |
 | [Insert label 'New' | teal | Use for temporary labels that need to grab attention, e.g. highligthing a new feature.|
 
 For counts, e.g. 'items in cart', use Badge instead.
 
### Principles
 
 1. Applies our color system
 2. Super short text only


## Anatomy

### Variation

* You can include an icon, provided the icon is simple, useful and has the same height as the font.

![label with icon](./img/Label/label_with_icon.png "Label with icon")

### Specification

![general spec](./img/Label/label_spec_general.png "General spec")

* Max length: 192px (of which text is max 184px)
* If text length > 184px, the text will be truncated with an ellipsis. Since there is no way to see the full content beyond the ellipsis, make sure to keep the text shorter than that!

![truncated label](./img/Label/truncated_label.png "Truncated label")

### Implementation

### Demo
