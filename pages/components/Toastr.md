# Toastr
Toast messages provide contextual information on an app’s processes, and disappear automatically after timeout.


## Usage
To communicate non-critical messages that inform users of a process that the system has performed or will perform in an non-interruptive manner. 

Rules
Should not be shown if a popup has just appeared before.
Appears temporarily and disappears automatically. They are minimally interruptive and often do not require users to take action.
Appears towards the bottom of the screen because the probability that user needs to act on it is low and because it does not block the screen content. 

#### Frequency
Only one toast message may be displayed at a time.

#### Actions
Toasts are used to confirm a user’s action. 
Toasts have 0 to 1 action. The one action cannot be **close**, **cancel** or **dismiss** since it is self-dismissing.
Example: “Item added to wish list (Undo)” or “Item removed from wish list (Undo)” or “Item added to cart (Undo)”



Important Note

Currently, iOS does not use toast messages or banners, and only uses pop-ups for feedback. This is not a good practise given how invasive it is.

We will implement toast messages and banners as part of the style guide component for use across all platforms.


## Anatomy
<image shows the composition of the component with annotations>
* Ref [Banners - Material Design](https://material.io/design/components/banners.html#anatomy)

* Ref [Snack bars - Material Design](https://material.io/design/components/snackbars.html#anatomy)



## Related components

* [Banner](/#/components/Banner)
* [Popup](/#/components/Popup)