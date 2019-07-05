# Pop Up
A pop up is a modal that informs the user about important information and requires a decision within the context of the page. 

```html
    <div class="container--fluid">
        <button class="btn btn-primary" onclick="showPopup()">Show
            popup</button>
        <div class="popup__backdrop" id="backdrop">
            <section class="popup" id="popup">
                <header class="popup__title">Title <i class="popupTitle__dismiss" onclick="hidePopup()"></i></header>
                <p class="popup__body">Please put your text description in here.</p>
                <footer class="popup__footer--compressed">
                    <button class="btn btn--outline popup__action--secondary" onclick="hidePopup()">Secondary</button>
                    <button class="btn btn--primary popup__action--primary" onclick="hidePopup()">Primary</button>
                </footer>
            </section>
        </div>
    </div>
```

## Behaviour
When the popup show, it blocks the user to interact with the main page until they confirm, dismiss or take the required action. With pop up, it makes the users focus on a single task. 

**Dismissing a popup**

Pop up has several ways to be dismissed. By clicking the cancel button, tap on the close icon (x) or by tapping outside the popup. 

## Usage
Only to inform important information that requires specific user action, decision or acknowledgement. 

## Anatomy


![Popup Specification.png](./img/popup/Popupspec.png)

**Title**: Tell about the purpose of the popup. The title is mandatory for every popup. Contain a brief, clear statement and explanation enough what this message about. Avoid apologies, alarm and ambiguity for the title. 

**Description**: Give more information/detail about the popup. 

**Action button**: A popup can contain a maximum of two actions. One must be a positive/confirming on the right side. Another is a dismissing on the left side. For a single action, it should be about acknowledgement. 

**Overlay/translucent background**: To cover the main page and make the user focus on the popup. 

Scrollable content is permitted only for terms and conditions.

## Placement 
Popup should be placed center align and in the middle of the screen to make the user focus on the message. 

## Order and alignment
The placement of the button on popup should be side by side if possible. But it can be stack as well to accommodate the longer text. 
