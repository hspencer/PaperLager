.PHONY: less

install:
	bower install

less:
	lessc less/pl.less css/pl.css --clean-css

css: less

dist:
	cp bower_components/jquery/jquery.min.js js
	cp bower_components/jquery-minicolors/jquery.minicolors.min.js js
	cp bower_components/processingjs/processing.js js
	cp src/PaperLager/web-export/PaperLager.pde .