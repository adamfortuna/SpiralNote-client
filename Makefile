

develop: 
	./node_modules/.bin/gulp watch &
	./node_modules/.bin/http-server public/

start: 
	./node_modules/.bin/http-server public/

install: 
	npm install
	./node_modules/.bin/bower install

watch: 
	./node_modules/.bin/gulp watch

build:
	./node_modules/.bin/gulp

.PHONY: start
