# Icon

You can download the icons [here](https://github.com/zalora/style/tree/master/assets/icon)

You can add the helper class `icon` to the svg code. e.g. `<svg class="icon" ...></svg>`. The helper class makes the svg icon inherite the font-size and color of it's parent. In the example below, the icon will have a size of 64px and pink color.

```html

<div class="icon__wrapper" style="font-size: 64px; color: pink;">
    <svg class="icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" focusable="false" fill="currentColor">
        <path d="M17.192 4.703c-1.702-.499-3.258-.071-4.549 1.21-.217.215-.093.213-.289.014-1.072-1.091-2.388-1.552-3.917-1.376-2.566.294-4.439 3-3.817 5.51.282 1.136.83 2.175 1.668 3.287 1.44 1.91 3.208 3.56 5.705 5.466.344.263.702.241 1.026-.023.188-.153.346-.277.685-.543l.024-.02c.489-.382.718-.565.991-.796 2.118-1.796 3.537-3.29 4.635-5.041.729-1.162 1.116-2.216 1.146-3.364l-.03-.32a3.948 3.948 0 0 0-.095-.619c-.43-1.727-1.514-2.896-3.183-3.385z"/>
    </svg>
</div>
```