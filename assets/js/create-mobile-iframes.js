/**
 * ZALORA styleguide
 * Creates iframes on mobile styleguide doc to be able to scope css styles
 */

console.log("--- init iframes");

var examples = document.querySelectorAll('.exampleOutputMobile'),
    iframeTemplateHead = '\
        <head> \
            <title>I am an iframe</title> \
            <link rel="stylesheet" href="http://styleguide.zalora.com/assets/css/mobile/styleguide.css"> \
            <style> \
                .example .container .full, \
                .example .container .half, \
                .example .container .one-third, \
                .example .container .two-thirds, \
                .example .container .one-quarter, \
                .example .container .three-quarters { \
                    padding: 10px 2px; \
                } \
                .highlightgrid .full, \
                .highlightgrid .half, \
                .highlightgrid .one-third, \
                .highlightgrid .two-thirds, \
                .highlightgrid .one-quarter, \
                .highlightgrid .three-quarters { \
                    border: 1px solid #A6C9A3; \
                    background-color: #DAFFD6; \
                } \
                .centergrid .full, \
                .centergrid .half, \
                .centergrid .one-third, \
                .centergrid .two-thirds, \
                .centergrid .one-quarter, \
                .centergrid .three-quarters { \
                    text-align: center; \
                } \
            </style> \
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
