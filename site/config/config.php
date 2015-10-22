<?php

/*

---------------------------------------
License Setup
---------------------------------------

Please add your license key, which you've received
via email after purchasing Kirby on http://getkirby.com/buy

It is not permitted to run a public website without a
valid license key. Please read the End User License Agreement
for more information: http://getkirby.com/license

*/

c::set('license', 'put your license key here');

/*

---------------------------------------
Kirby Configuration
---------------------------------------

By default you don't have to configure anything to
make Kirby work. For more fine-grained configuration
of the system, please check out http://getkirby.com/docs/advanced/options

*/
c::set('debug', false);
c::set('isLive', true);
c::set('isLocal', 0);
c::set('isDev', 0);

// Don't wrap images in figures
// http://getkirby.com/docs/cheatsheet/options/kirbytext-image-figure
c::set('kirbytext.image.figure', false );

// Don't redirect to https
// http://getkirby.com/docs/cheatsheet/options/ssl
c::set('ssl',false);

// The base URL for the site. When set to false, Kirby auto-detects the correct URL.
// http://getkirby.com/docs/cheatsheet/options/url
c::set('url','http://presentation.dev');