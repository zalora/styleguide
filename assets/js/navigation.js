/**
 * ZALORA styleguide
 * Navigation logic
 */

console.log("--- init nav");

/**
 * Toggle menu on mobile devices
 */
var menuIcon  = document.getElementById('menu-icon'),
    pageMover = document.getElementById('page-mover'),
    siteNav   = document.getElementById('site-nav');

menuIcon.addEventListener('click', function(e) {
    if (hasClass(pageMover, 'moved')) {
        removeClass(pageMover, 'moved');

        setTimeout(function() {
            removeClass(siteNav, 'showing');
        }, 500);
    }

    else {
        addClass(pageMover, 'moved');
        addClass(siteNav, 'showing');
    }
}, false);
