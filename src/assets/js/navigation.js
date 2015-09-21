/**
 * ZALORA styleguide
 * Navigation logic
 */

console.log("--- init nav");

var menuIcon = document.getElementById('menu-icon'),
    pageMover = document.getElementById('page-mover');

menuIcon.addEventListener('click', function(e) {
    if (hasClass(pageMover, 'moved')) {
        removeClass(pageMover, 'moved');
    }

    else {
        addClass(pageMover, 'moved');
    }
}, false);
