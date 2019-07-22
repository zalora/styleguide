# Radio Button
A radio button is a selection control that allows users to select only one of the options given. 

```html
<div class="radio">
    <input id="radio-1" type="radio" name="radio-test">
    <label class="click__target" for="radio-1">Radio 1</label>
</div>
<div class="radio">
    <input id="radio-2" type="radio" name="radio-test">
    <label for="radio-2">Radio 2</label>
</div>
<div class="radio is-disabled">
    <input id="radio-3" type="radio" name="radio-test">
    <label for="radio-3">Radio 3</label>
    <span class="radio__helper">Discription</span>
</div>
```

## Usage
<span class="u-text-positive">Do</span>
  * Single select from the options given.
  * Auto selects the neutral or the safest selection option. The exception only for gender selection on the signup screen.
  * Show all the options and don't hide it.

<span class="u-text-urgent">Don't</span>
  * Put a background colour for the selection. 
  * Use radio button for multiple selections.


  
## Anatomy

![Radio button](img/radiobutton/Radiospec.png)

* The radio icon should be on the left side. And native behaviour like ripple can be applied for the mobile platform. 

* If there is enough space, you can put the radio button side by side, like on the sign up screen.

* **The behaviour** is when the user select another option, it will de-select the current selection.




## Write for radio button
  * Start with a capital letter.  
  * Don't end it with punctuation. 
  * Keep the text in a single line. 
  * All options should be distinct from each other and not vague or misleading.
  * Use the same phrasing for all options.



## Order and alignment

Be listed according to logical order, whether is an alphabetical, most popular or time-based order. 

![Radio button list](img/radiobutton/Radiobuttonlist.png "Radio button for sort. The order is based on the most popular option.")

![Radio button side by side](img/radiobutton/Sidebysideradiobutton.png "Radio button on sign up screen. The order is based on the alphabet.")


## Related components
[Checkbox](/#/components/Checkbox)