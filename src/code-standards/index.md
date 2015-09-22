---
layout: page
title: "Coding standards"
---

# Naming conventions

## 1. We follow BEM methodology, meaning Block, Element, and Modifier.

    .block {}
    .block__element {}
    .block--modifier {}

- block represents the higher level of an abstraction or component.
- block__element represents a descendant of .block that helps form .block as a whole.
- block--modifier represents a different state or version of .block.

## 2. JS-someName

- CSS must not use js-* classes in selectors.
Use the id attribute and js-* class names are reserved for JavaScript-only use. Application-specific data or content can be stored in data-* attributes.

The example below includes a dedicated JavaScript utility class to which behaviour is bound. It is independent of any specific UI component.

    <a class="js-showProfile" data-username="necolas" href="{url}">View</a>


## 3. cms-someName
All css class name belongs to CMS should start with cms-*

Eg:

    <div class="cms-homepage_banner">
      Content from CMS
    </div>

