# Button
A button is indicates a possible user action. Should be visible and inform the users on what will happen when they click on it. 


## Type
  * **Primary button** 
    ```html
    <button class="btn btn--primary">Primary</button>
    ```
    The main to action button. Should appear once per screen and not every screen need a primary button. 

  * **Outline button**
    ```html
    <button class="btn btn--outline">Outline</button>
    ```
    A secondary action button. For another option other than the primary call to action. 

  * **Apply button**
    ```html
    <button class="btn btn--special">Apply</button>
    ```

    Only use for the active state of the apply button. The initial state will be the disabled state and only after users start typing it changes to this button. 

  * **Disable button**
    ```html
    <button class="btn btn--special is-disabled">Disabled</button>
    <button class="btn btn--primary is-disabled">Disabled</button>
    ```
    Users need to complete an action before the button is active. Mostly use with the primary and apply button. 

    ***Note that***, the disable state is the same for all buttons.

  * **Text link**
    ```html
    <button class="btn btn--link">Hyperlink</button>
    ```
    Use to navigating to another page. 

  * **Subtle**
    ```html
    <button class="btn btn--subtle">Subtle</button>
    ```
    If in one group of content there are more than 3 links use subtle.

  * **Negative button**
    ```html
    <button class="btn btn--danger">Danger</button>
    ```
    Only appears as a final confirmation for a destructive action such as deleting. 


## Usage
<span class="u-text-positive">Do</span>
  * A stand alone element but also can use together with popup, bottom modal, forms, etc.
  * Use a general and meaningful icon. 

<span class="u-text-urgent">Don't</span>
  * Use gradient colour for the button.
  * Place another button below if there is enough space next to it. 
  * Put the button randomly. 



## Anatomy

A button can contain text only, icon only or the combination of text and icon. 

![Button Specification](img/button/Buttonspec.png "There are 2 sizes of a button. The default size is 48px and for the small one is 40px.")

## Order

![Full width button.png](img/button/Fullwidthbutton.png "Full-width button: for the main action users should take.")
  
  

![Side by side button.png](img/button/Sidebyside.png "Side by side button: mostly for step. When the next and previous step is equally important. The right one must be a positive action.")

  
![Stack button.png](img/button/Stackbutton.png "Top bottom button: for a longer text. The top one must be a positive action")



## Length
There are 2 types of button length:
  * Full-width button: Always have same margin left and right with the minimum is 16px to the edge of the screen.
  * Fixed width button: Always have 16px margin left and right after the text. So, the length of the button is dynamic. 



## Usage
Icon button:
  * Used for external and internal branding.
  * Used in a limited space but must have a universal meaning across the regions.
  * Don't use more than one icon in one button. 

Text and icon button:
  * Horizontal align the icon and text within the button. 
  * Use a centre align.  



## Write for button
  * Make it as short as possible but also clearly explaining the result of the button.
  * Concise and fit within a single line.
  * Between two to five words.
  * Free from any punctuation.
  * In title case regardless of platform.
  * Always start with a verb and continue with the subject. The subject will help to add context. 
  * Use impactful verbs to grab users attention.
