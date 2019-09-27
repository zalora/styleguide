# Lists

Lists are continuous, vertical indexes of text with or without image and action.

```html
<div class="row">
	<div class="col-sm-1">
		<ul class="list">
			<li class="list__item">
				<div class="listItem__text">
					<div class="listItemText__title">Title only</div>
				</div>
			</li>
			<li class="list__item is-compact">
				<div class="listItem__text">
					<div class="listItemText__title">Title only (compact)</div>
				</div>
			</li>
			<li class="list__item">
				<img class="listItem__icon" src="img/list/next.svg" />
				<div class="listItem__text">
					<div class="listItemText__title">Title</div>
				</div>
				<div class="listItem__metadata">2 items left</div>
			</li>
		</ul>
	</div>
</div>
```
List items are fluid, in the above example, we used grid class `col-sm-1` to set the width of the list items.

## Usage

Lists are used to display large or small amounts of information cleanly and efficiently one after the other.

Lists should be sorted in logical ways that make content easy to scan, such as alphabetical, numerical, chronological, or user preference. They can be organised using headers, dividers and spacing. Use dividers sparingly, to create groupings rather than separate items.

![List Usage](img/list/List_usage.jpg)


## Anatomy
![List Anatomy](img/list/List_Anatomy.jpg)

List is composed of the following elements:

Primary text

* The text is body text
* The text is in grey_100
* It is centre aligned vertically for single or line
* Text has 16px margin on both sides 

```html
<div class="row">
	<div class="col-sm-1">
		<ul class="list">
			<li class="list__item">
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
				</div>
			</li>
		</ul>
	</div>
</div>
```

Icon/ image /control

* Icon size is 24 x 24 px
* Image size is 40 x 40 px
* the control is one of the following: checkbox, radio

```html
<div class="row">
	<div class="col-sm-1">
		<ul class="list">
			<li class="list__item">
				<img class="listItem__img" src="https://static-sg.zacdn.com/cms/categories/main/sub/ViewAllWOMEN.jpg" />
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
				</div>
			</li>
			<li class="list__item">
				<img class="listItem__icon" src="img/list/next.svg" />
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
				</div>
			</li>
			<li class="list__item">
				<div class="listItem__control">
					<div class="radio">
						<input type="radio" name="test" value="1" checked>
						<label for="radio_11"/>
					</div>
				</div>
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
				</div>
			</li>
		</ul>
	</div>
</div>
```

Secondary text (description)

* The secondary text is caption/tiny text 
* The text colour is in GREY-80 (#474747)

```html
<div class="row">
	<div class="col-sm-1">
		<ul class="list">
			<li class="list__item">
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
					<div class="listItemText__description">Secondary/ Descrtiption text</div>
				</div>
			</li>
		</ul>
	</div>
</div>
```

SecondaryAction/ metadata

* The secondary action tells what is going to happen when the user clicks on the list item
* The metadata provide essential metadata about the list item

```html
<div class="row">
	<div class="col-sm-1">
		<ul class="list">
			<li class="list__item">
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
				</div>
				<div class="listItem__metadata">metadata</div>
			</li>
			<li class="list__item">
				<div class="listItem__text">
					<div class="listItemText__title">Primary Text</div>
				</div>
				<div class="listItem__secondaryAction">
					<img src="img/list/next.svg">
				</div>
			</li>
		</ul>
	</div>
</div>
```

