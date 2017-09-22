WEBROOT = /var/www
TARGET = ${DESTDIR}${WEBROOT}/app
INSTALL = install -m 0644

appname:
	install -d ${TARGET}
	${INSTALL} .gitignore           ${TARGET}
	${INSTALL} build                ${TARGET}
	${INSTALL} Gemfile              ${TARGET}
	${INSTALL} iteration            ${TARGET}
	${INSTALL} Makefile             ${TARGET}
	${INSTALL} setup.sh             ${TARGET}
	${INSTALL} version              ${TARGET}
	${INSTALL} README.md            ${TARGET}
