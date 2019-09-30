# Toastr
Toast messages provide contextual information on an app’s processes and disappear automatically after a timeout.

```html
<div> Adjust the screen size to see how toastr is shown on desktop and mobile</div>
<div class="row u-margin-top-l">
    <div class="col">
        <div id="toast-2" class="toast">
            <div class="toast__body">
                Write your toast message here up to 2 linesWrite your toast message here up to 2 linesWrite your
                toast message here up to 2 lines
            </div>
        </div>
    </div>
</div>
```


## Usage
To communicate non-critical messages that inform users of a process that the system has performed or will perform in a non-interruptive manner. 

Rules
Should not be shown if a popup has just appeared before.
Appears temporarily and disappears automatically. Tostrs are minimally interruptive and often do not require users to take action.
Appears towards the bottom of the screen because the probability that a user needs to act on it is low and because it does not block the screen content. 

#### Frequency
Only one toast message may be displayed at a time.

#### Actions
Toasts are used to confirm a user’s action. 
Toasts have 0 to 1 action. The one action cannot be **close**, **cancel** or **dismiss** since it is self-dismissing.
Example: “Item added to wish list (Undo)” or “Item removed from wish list (Undo)” or “Item added to cart (Undo)”



Important Note

Currently, iOS does not use toast messages or banners and only uses pop-ups for feedback. This is not a good practice given how invasive it is.

We will implement toast messages and banners as part of the style guide component for use across all platforms.


## Anatomy
The toastr is 16px above the bottom edge of the screen.
On desktop, it is on the bottom left corner of the screen.

![toastr anatomy, desktop](img/toastr/toastr_anatomy_desktop.png "toastr on desktop")

On mobile, it is on the centre bottom of the screen.

![toastr anatomy, mobile](img/toastr/toastr_anatomy_mobile.png "toastr on mobile")



## Related components

* [Banner](/#/components/Banner)
* [Popup](/#/components/Popup)