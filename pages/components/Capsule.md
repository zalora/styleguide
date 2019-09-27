# Capsule

Capsule is a compact list component used for navigation. It is a simple component with only primary text and image. It does not have any action inside it.

```html
<div class="row">
	<div class="col-sm-1">
		<div class="capsule">
			<img class="capsule__img" src="https://static-sg.zacdn.com/cms/categories/main/sub/ViewAllWOMEN.jpg" />
			<div class="capsule__label">Label</div>
		</div>
	</div>
	<div class="col-sm-1">
		<div class="capsule">
			<img class="capsule__img" src="https://static-sg.zacdn.com/cms/categories/main/sub/ViewAllWOMEN.jpg" />
			<div class="capsule__label">Label with multiple lines</div>
		</div>
	</div>
</div>
```

## Usage

![capsule usage](img/capsule/capsule_usage.jpg)

Capsule is used to show a quick overview of a large number of list items. It helps reduce the amount of scroll that comes with full width list component.
However, the description text should be short to fit in the shorter width.

Like list, it can be grouped with a list header


## Anatomy

![Capsule](img/capsule/capsule_anatomy.jpg "Capsule Anatomy")

Capsule is composed of the following elements:

* Primary text
	* The text is body text
	* It is centre aligned vertically (for both single or two line)
	* Text has 8px margin on both sides 

* Image
	* Image size is 48 x 64 px

* Background
	* Background is #F5F5F5 with rounded corner radius of 2px
	* Length of the chip is 2 columns and hence dependent on screen size
