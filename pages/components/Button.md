# Button

## What is button?

Button should be visible and should inform users on what will happen when they click/tap on it.
Button can contain a combination of text and icon while links are always text.

![Facebook button](./img/Button/fb.png "Continue with Facebook")

Icon: Should have meaning and help user to identify the use of the button.
Text: Should indicates some form of action. 

For web we use it in:
- add to wishlist
- sign in with facebook
- can’t find yur size
- add new address

For IOS app we use it in:
- scan QR Code
- inside my account (login,order,etc)
- login with facebook
- see more in cart breakdown

For Android app we use it in:
- inside my account (login,order,etc)
- login with facebook
- see more in cart breakdown

We use icon: for branding (external, internal). For consistency between all platform. And the icon should be universal enough for people to recognise across regions.
For mobile: Icon will be used when the space is limited or for indicate a quick action (ex: wishlist)

## Writing in Button
Make it as short as possible but also clearly explaining the result of the button.

## Button Copy Guidelines
Text within buttons should always be:
- Concise and fit within a single line
- Between two to five words
- Free from any punctuation
- In title case, regardless of platform (i.e. Android, iOS, web)

Generally, button copy falls within these two categories:

1. Action (e.g. CTA)
Copy should always start with a verb, followed by the subject. Unless it’s obvious what the subject is (for instance, placing an “Edit” button next to a delivery address), always include the subject in the button (e.g. “Edit Profile”) for added context.

Don’t be afraid to use impactful verbs (e.g. “Continue” instead of “Next”, “Discover” instead of “Find Out:”) to grab the audience’s attention.

Good example: 
“Add New Address”

2. Acknowledgement 
Copy should do the following:
- Be a follow-up of the preceding text within the window or page
- Confirm the previous action performed by the user 
- Guide the user towards the next page/action upon clicking the button

As much as possible, avoid using “OK” as it’s too ambiguous and leaves excessive blank space within the button. 

Good example:
Title - “Credit Card Details Saved!”
Button 1 - “Add Another Card”
Button 2 - “View Saved Card(s)”

![Button acknowledgement](./img/Button/wording.png "Button acknowledgement")

## Button Order. 
Positive action should be in the right side. 
Positive action should be differentiated from negative actions e.g. more eye catching colour or bold text.
![Button order](./img/Button/order.png "Button order")

## Button Variation

1. <button class="btn btn--primary"> Primary Button</button>  is the primary CTA for an action or highlight the strongest call to action on a page.
Primay button should appear once per screen and not every screen needs a primary button.
**Example**: Add to Bag, Continue. And the exception is in Wishlist, because have primary action
in every list and list like accordion (in order tracking screen).

2. <button class="btn btn--outline"> Outline Button</button> If you have another option rather than primary CTA, you should use this.
In the screen you already have primary button, you should use this button. Use this in button
with banner. Example: Continue shopping, Cancel, Back

3. <button class="btn btn--special"> Special Button</button> We will use this for the active state for apply button. However, the default state should be the disable button when the field not in use. 

4. <button class="btn btn--primary is-disabled"> Disable Button </button>Use when another action has to be completed before the button is usable. Mostly use with primary button, only for apply field using with the special teal button.  

5. <button class="btn btn--link">Link Buttons</button> are used to navigate to another page and should open in the current window unless: terms and conditon page or the destination is an external site.

6. <button class="btn btn--subtle">Subtle</button>If in one paragraphy you have more than 3 link, you can use <button class="btn btn--subtle">Subtle</button> for link button. ex: breadcrumbs

7. <button class="btn btn--danger">Danger Button</button>Indicates what critical for zalora user. Only appear on dialog.
The danger button appears as a final confirmation for a destructive action such as deleting. Use mostly in confirmation modals. ex: delete credit card


```html
<button class="btn btn--primary"> Primary </button>
<button class="btn btn--outline"> Outline Button</button>
<button class="btn btn--special"> Special </button>
<button class="btn btn--primary is-disabled"> Disabled Button</button>
<button class="btn btn--link">Link Buttons</button>
<button class="btn btn--subtle">Subtle</button>
<button class="btn btn--danger">Danger Button</button>
```

## Button size