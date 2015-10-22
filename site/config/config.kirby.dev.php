<?php
	c::set('debug', true);
	c::set('cache', false);
	c::set('isLive', false);
	c::set('isLocal', true);
	c::set('isDev', true);

	c::set('content.file.ignore',array(
		'devAssets/'
	));

	c::set('url','http://kirby.dev');