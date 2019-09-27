# Textfield

Text fields let users enter and edit text that automatically brings up a keyboard when the user taps it. Display a ‘Clear’ button in the right end of a text field when appropriate.

```html
<div class="row u-margin-vertical-m">
  <div class="col">
    <div class="textField">
      <input id="input--default" type="text" value="Input Text" class="has-value">
      <button class="textField__clearBtn"></button>
      <label for="input--default">Label text</label>
      <span class="textField__helper">Helper text</span>
    </div>
  </div>
</div>
```

## Usage

Text field is used to request a small amount of information, such as an email address. For multiline or text entry, use a multiline textfield instead. It would generally be used on login or profile information screens.


## Anatomy

Textfield is composed of following elements:

Label text
	
* The text is body text

Outline
	
* The colour of outline determines the state of the textfield
	* grey_20 for disabled state
	* grey_60 for normal textfields 
	* red_90 for error state
	* green_90 for textfields with specific inputs
	* grey_100 for highlighted state

Helper text

* Helper text is micro text that is used to convey extra information like if a textfield is mandatory or rules for input

Secondary text 

* The label text morphs to micro text in focussed, error and filled states and rests on top of the input text

Input text

* Input text is body text in grey_100 with curser and keyboard expanded

Clear icon

* The clear button appears when the textfield is in focussed state and user is typing in. For example, it replaces the error icon in non-focussed error state when the textfield is in focus.

Error message

* Error message is used to give user the contextual information like what is the error or how to resolve it. If a textfield has helper text, then the same turns to error message.

Textfield icon

* Based on state of the textfield, the textfield can have an icon, like the error exclamation icon in error state or the check mark icon in case of success textfield


## State
* **Valid**

```html
<div class="row u-margin-vertical-m">
  <div class="col">
    <div class="textField">
      <input id="input--valid" class="is-valid" type="text" value="Input text">
      <label for="input--valid">Valid</label>
      <span class="textField__helper">Helper text</span>
    </div>
  </div>
</div>
```

* **Invalid**

```html
<div class="row u-margin-vertical-m">
  <div class="col">
    <div class="textField u-margin-top-l">
      <input id="input--invalid" type="text" class="is-invalid" value="Input text">
      <label for="input--invalid">Invalid</label>
      <span class="textField__helper">Helper text</span>
    </div>
  </div>
</div>
```

* **Disabled**

```html
<div class="row">
  <div class="col">
    <div class="textField">
      <input id="input--disabled" type="text" disabled>
      <label for="input--disabled">Disabled</label>
    </div>
  </div>
</div>
```