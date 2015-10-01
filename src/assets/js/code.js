---
---


/**
 * Grab extra classnames from below rendered code examples
 * and add them to example container
 */

var codeExamples = document.getElementsByClassName('codeExample');

for (i = 0; i < codeExamples.length; i++) {
    var siblingElement = codeExamples[i].nextElementSibling;

    if (siblingElement && siblingElement.nodeName == "BLOCKQUOTE") {
        // Grab the classnames from that blockquote element and apply them to the
        // code example container
        addClass(codeExamples[i].children[0], siblingElement.children[0].innerHTML);

        // throw away that blockquote that we dont need anymore
        siblingElement.remove();
    }
}

/**
 * Creates iframes on mobile styleguide doc to be able to scope css styles
 */
var examples = document.querySelectorAll('.exampleOutputMobile'),
    iframeTemplateHead = '\
        <head> \
            <title>I am an iframe</title> \
            <link rel="stylesheet" href="{{ "/assets/css/local/mobile-examples.css" | prepend: site.url }}"> \
            <link rel="stylesheet" href="{{ "/assets/css/mobile/styleguide.css" | prepend: site.url }}"> \
        </head> \
        <body>';
    iframeTemplateFoot = '</body>';


for (i = 0; i < examples.length; i++) {
    // create a new iframe to be inserted in the code examples place
    var iframe = document.createElement('iframe'),
        example = examples[i],
        exampleContent = example.outerHTML,
        html = iframeTemplateHead + exampleContent + iframeTemplateFoot;

    // Populate the new iframe with content
    iframe.src = 'data:text/html;charset=utf-8,' + encodeURI(html);

    // Clear out example container to make room for iframe
    example.innerHTML = "";

    // Add iframe into the appropriate place into the document
    example.appendChild(iframe);
}

