---
---
/**
 * ZALORA styleguide
 * Creates iframes on mobile styleguide doc to be able to scope css styles
 */

console.log("--- init iframes");

var examples = document.querySelectorAll('.exampleOutputMobile'),
    iframeTemplateHead = '\
        <head> \
            <title>I am an iframe</title> \
            <link rel="stylesheet" href="{{ "/assets/css/mobile/styleguide.css" | prepend: site.url }}"> \
        </head> \
        <body>';
    iframeTemplateFoot = '</body>';


for (i = 0; i < examples.length; i++) {
    // create a new iframe to be inserted in the code examples place
    var iframe = document.createElement('iframe'),
        example = examples[i],
        exampleContent = example.innerHTML,
        html = iframeTemplateHead + exampleContent + iframeTemplateFoot;

    // Populate the new iframe with content
    iframe.src = 'data:text/html;charset=utf-8,' + encodeURI(html);

    // Clear out example container to make room for iframe
    example.innerHTML = "";

    // Add iframe into the appropriate place into the document
    example.appendChild(iframe);
}
