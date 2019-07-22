# Divider
A divider is a line to group content to help users scan the content faster. 

```html
Primary divider :
<div class="divider"></div>

Secondary divider:
<div class="divider--secondary"></div>

Thick divider:
<div class="divider--thick"></div>
```


## Type
There are two types of a divider:

#### Thin divider
To group related / same level content.
<div class="row">
![thin divider in the cart screen](img/divider/thindivider_cart.png "Do[On the cart screen, the divider makes a clear grouping per item in one seller.]") ![wrong thin divider in the pdv screen](img/divider/wrongthindivider_pdv.png "Don't[If you need to group text-only information is better to play with the spacing rather than put too much divider.]")
</div>

#### Thick divider
To group unrelated / different level content.
<div class="row">
![thick divider in the cart screen](img/divider/thickdivider_cart.png "Do[On the cart screen, the divider makes a clear grouping per seller.]") ![thick divider in the pdv screen](img/divider/thickdivider_pdv.png "Do[On the PDV screen, the divider devide the information between the information about the item and item suggestion.]") ![wrong thick divider in the wishlist screen](img/divider/wrongthickdivider_wishlist.png "Don't[On the wishlist screen, the item here has the same level so it should use a thin divider.]")
</div>

## The Usage
<span class="u-text-positive">Do</span>
  * Differentiate / group the content.
  * Create a hierarchy and divide the content into two sections.

<span class="u-text-urgent">Don't</span>
  * Use too many dividers because it can confuse the users.
  * Make a random length for the divider. 
  * Stack a divider.



## Anatomy
![Divider specification](img/divider/Divider_spec.png)

| Type | Colour | Thick (px) | Margin (left right) |
| :---------: |:---------:| :--------:| :---------:|
| primary divider | #DEDEDE | 1px | 16px |
| secondary divider | #F4F4F4  | 1px | 16px |
| thick divider | #F4F4F4  | 8px | no margin |

Remember,  if you use a divider to group the content, you should have a minimum of 8 px space of the margin top and bottom. 
