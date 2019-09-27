# Checkbox
A checkbox is a selection control that allows users to select multiple options, single or no option at all. 

```html
<div class="checkbox">
    <input id="checkbox-1" type="checkbox">
    <label class="click__target" for="checkbox-1">Checkbox 1</label>
</div>

<div class="checkbox">
    <input id="checkbox-2" type="checkbox">
    <label for="checkbox-2">Checkbox 2</label>
    <span class="checkbox__helper">description</span>
</div>
 
```


## Type and State

### Checkbox
* For an acknowledgement (like terms and conditions) : the default state is not checked.
* For a marketing purpose (subscribe newsletter) : the default state is checked. 

![General checkbox](img/checkbox/Generalcheckbox.png)

### Filter checkmark
* Using a specific check icon and for filter only.  
* For this checkmark, the default state means opt-in all option. And the active state means select some option. 

![Filter checkmark](img/checkbox/Filtercheckmark.png)

To change the normal checkbox to filter checkbox, you just need to change the class name from `checkbox` to `filterCheckbox`

```html
<div class="filterCheckbox">
    <input id="filter-1" type="checkbox">
    <label for="filter-1">Filter 1</label>
</div>
<div class="filterCheckbox">
    <input id="filter-2" type="checkbox">
    <label for="filter-2">Filter 2</label>
    <span class="filterCheckbox__helper">description</span>
</div>
          
```

## Usage
<span class="u-text-positive">Do</span>
  * For multiple selections for the option given. 
  * Contextual, not too far away from the related content.

<span class="u-text-urgent">Don't</span>
  * Put background colour for selected option.



## Anatomy
![Checkbox Specification](img/checkbox/Checkboxspec.png)

The icon should be on the left side. And native behaviour like ripple can be applied for the mobile platform. 



## Write for radio button
  * Use a positive and active wording.
  * Start with a capital letter.  
  * Don't end it with punctuation. 
  * Keep the text in a single line. 
  * All options should be distinct from each other and not vague or misleading.



## Related components
[Radio button](/#/components/Radio)