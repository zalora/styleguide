# Typography

Typography helps you to express your design and contents in a percise and efficient way.

## Font
#### System Font stack
In Style, we use the native system font stack. The reason can be various, but the most important two are:
* It boosts the performance because the browser doesn’t have to download any font files. 
* It matches the OS, and provide a comfortable look to our audience.
There are many ways to apply system fonts. The one we are using is:

`
font-family: apple-system,blinkmacsystemfont,”SegoeUI”,”Roboto”,”Oxygen”,”Ubuntu”,”FiraSans”,”DroidSans”,”HelveticaNeue”,sans-serif;
`

#### Expressive font
For headlines, you can choose an expressive font. Expressive fonts are unconventional font designs have details and intricacy that help attract the eye. In ZALORA, we use **High Tide** as our expressive font. However, we should only use it on banners and marketing materials, but not in our content(codebase). The preferrerd way is to convert the part that needs to be **High Tide** to image, and load the image.

High Tide is used in the brand page of ZALORA website:
![Example of High Tide font](img/typography/Browse_Our_Brands.png )

## Readability
#### Font-size
The default font-size in Style is **16px**. Text has font-size smaller than 16px should only be used in captions, metadata, or less important information.

| Category    | Font-size | Line-height | Usage|
|:--------------------:|:-----------:|:-------------:|:----:|
| <h1>Heading 1</h1> | 48px | 1.33 * 48px |`<h1></h1>`|
| <h2>Heading 2</h2> | 40px | 1.4 * 40px |`<h2></h2>`|
| <h3>Heading 3</h3> | 32px | 1.5 * 32px |`<h3></h3>`|
| <h4>Heading 4</h4> | 24px | 1.67 * 24px |`<h4></h4>`|
| <h5>Heading 5</h5> | 20px | 1.6 * 20px |`<h5></h5>`|
| <h6>Heading 6</h6> | 20px | 1.3 * 20px |`<h6></h6>`|
| <p class="u-font-weight-bold">Strong</p> | 16px | 1.5 * 16px |`<strong></strong>`|
| <p class="u-font-weight-medium">Medium</p> | 16px | 1.5 * 16px | `<mark></mark>`|
| <p>default body</p> | 16px | 1.5 * 16px | Any tag without special styling|
| <p class="u-text-caption">caption</p>| 14px | 1.5 * 14px |`<small></small>`|
|<p class="u-text-micro">Micro</p>| 12px | 1.5 * 12px |`<span class="u-text-micro"></span>`|


#### Letter-spacing

In style, we encourage to use the default letter-spacing, and kind of overriding should be prohibited. This can guarantee the readability of our text content. While the adjustment of the letter spacing is allowed when creating banners and marketing materials. 

#### Color

When you use text on a background other than black/white, please check the color swatches here to find which color should you use so that it guarantees the readability your content.

#### Line height

Line height is the amount of apace between beaslines in a block of text. A text's line-height is proportional to its font size.

![line-height demostration for font size 16px](img/typography/line-height-16px.png "The line height for text with font-size 16px, is 24px")

![line-height demostration for font size 20px](img/typography/line-height-20px.png "The line height for text with font-size 20px, is 32px")

#### Emphasize Information

You can use font-weight, size, and color to highlight the most important information in your app. 

* **Color**

Be careful when you want to use color to highlight information. Generally, colors help us to convey additional information, e.g. green for positive and red or negative. Also, you can consider if *label* is a better choice before you apply color to your text.

* **Weight**

Change font-weight can be a common way to emphasize inline information.
Weight refers to the relative *thickness* of a font’s stroke. A typeface can come in many weights, e.g. light, regular, medium and bold.
In style, we have 3 fonts weights:


| Weight        | Usage   | Example |
| ---------| ------------| ---------|
| Regular (400) | The default font weight  | <div>Body</div>    |
| Medium (500)  | Used for special purpose, usually with green or red color to convey positive or negative informations. | <p class="u-text-positive">Positive</p> <p class="u-text-urgent">Urgent</p>   |
| Bold (700)    | To emphasis the keywords, usually with the default or grey color to distinct from the normal body.     |<p class="u-font-weight-bold">Strong</p> |