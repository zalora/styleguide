# Tooltip
A tooltip is a brief, informative message that appears when users hover over or tap an element.

## Usage
* **Indicative Tooltips**

Add tooltips to icons that are likely unfamiliar to many users. Use a tooltip to describe the purpose of the icon is very helpful.

![Alibaba](img/tooltip/alibaba.png "Alibaba had a search bar with an unlabeled camera icon. When users hovered over this icon, a tooltip that reads Search by image appeared. This functionality was likely unfamiliar to many users, and therefore a tooltip describing its purpose was helpful.")


* **Info Tooltips**

Use tooltip to provide additional information for some particular words. This kind of tooltips is usually attached to an ? or i icon that is placed after the particular word.

![Info tooltip example: Additional International Fee](img/tooltip/additional_fee.png "Example: Additional International Fee. An info tooltip is very helpful here to explain to the customers about what the additional international fee is.")


![thin divider in the cart screen](img/divider/thindivider_cart.png "Do[On the cart screen, the divider makes a clear grouping per item in one seller.]") ![wrong thin divider in the pdv screen](img/divider/wrongthindivider_pdv.png "Don't[If you need to group text-only information is better to play with the spacing rather than put too much divider.]")


```html
<div id="tooltip-top" class="btn btn--primary" data-title="Tooltip on the top" data-placement="top">Top</div>
<div id="tooltip-right" class="btn btn--primary" data-title="Tooltip on the right" data-placement="right">Right</div>
<div id="tooltip-bottom" class="btn btn--primary" data-title="Tooltip on the bottom" data-placement="bottom">Bottom</div>
<div id="tooltip-left" class="btn btn--primary" data-title="Tooltip on the left" data-placement="left">Left</div>
```
