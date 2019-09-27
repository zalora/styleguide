# Expansion Panel
An expansion panel can help us to solve various problems: display large amount of information in limited screen space, create flows, provide light weight editing.

## Usage
* *Displaying large amount of information*

Expansion panels are useful for reducing vertical space with large amounts of information. Additionally, it expands and shows the more important information and hide the noise for the audience. 

* *Creating flows*

Expansion panels may be displayed in a sequence to form a flow.  For example, in ZALORA desktop checkout, we use a series of expansion panels to collect information required by an order, user’s information -> address -> payment -> order items and discount.

* *Light weight editing*

With studies, expansion panels are best used for lightweight editing of an element, such as selecting a value for a setting. It provides the audience enough context and won’t interupt their options. A good example is also ZALORA desktop checkout page.

## Behaviour
There are two types of expansion panel:
* Independent expansion panels:

The expanded/collapsed status are independent between panels. Meaning, you can expand as many panels as you want.

* Accordion:
You can expand at most one panel in the same time.

Check the behavior out from this interactable demo in [@zalora/style-react](https://zalora.github.io/style-react/#!/ExpansionMenu). (allowOnlyOneExpanded={true} => Accordion, allowOnlyOneExpanded={false} => Independent expansion panel.)

```html
<ul class="expansionMenu">
  <li class="expansionMenu__item is-expanded" onclick="togglePanel(this, 'expansionMenuItem__body-1')">
    <div class="expansionMenuItem__title">Title</div>
    <div id="expansionMenuItem__body-1">
      <div class="expansionMenuItem__description">
        description here many many words<br>
        description here many many words<br>
        description here many many words
      </div>
    </div>
  </li>
  <li class="expansionMenu__item is-expanded" onclick="togglePanel(this, 'expansionMenuItem__body-2')">
    <div class="expansionMenuItem__title">Title</div>
    <div id="expansionMenuItem__body-2">
      <div class="expansionMenuItem__description">description here many many words</div>
    </div>
  </li>
</ul>
```

## Spec 