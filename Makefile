.PHONY: less

install:
	bower install

less:
	lessc less/pl.less css/pl.css --clean-css

css: less

dist:
	cp bower_components/processingjs/processing.js js
	cp bower_components/jquery/jquery.min.js js