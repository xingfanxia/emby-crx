gen:
	cp -r content/* output/
	cp -r static/js/* output/
	cp -r static/css/* output/

emby:
	cp -r /volume2/coding/output/* . && chown -R emby:emby common-utils.js jquery-3.6.0.min.js main.js md5.min.js style.css config.js && chmod 644 common-utils.js jquery-3.6.0.min.js main.js md5.min.js style.css config.js