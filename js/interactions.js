$.minicolors = {
	defaults: {
		animationSpeed: 50,
		animationEasing: 'swing',
		change: null,
		changeDelay: 0,
		control: 'hue',
		defaultValue: '',
		hide: null,
		hideSpeed: 100,
		inline: false,
		letterCase: 'uppercase',
		opacity: false,
		position: 'bottom right',
		show: null,
		showSpeed: 100,
		theme: 'default'
	}
};

function addNoise(){
	var pjs = Processing.getInstanceById('PaperLager');
	pjs.addNoise();
}

function zoomIn(){
	var pjs = Processing.getInstanceById('PaperLager');
	pjs.zoomIn();
}

function zoomOut(){
	var pjs = Processing.getInstanceById('PaperLager');
	pjs.zoomOut();
}

function reset(){
	var pjs = Processing.getInstanceById('PaperLager');
	pjs.setup();
}

function saveImage(){
	var canvas = document.getElementById("PaperLager");
	var context = canvas.getContext("2d");
	window.location = canvas.toDataURL("image/png");
}

onload = function() {
	document.getElementById('anchoTrazo').oninput = function(){ 
		document.getElementById('anchoTrazo-out').innerHTML = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateAnchoTrazo(this.value);
	};

	document.getElementById('anchoTrama').oninput = function(){ 
		document.getElementById('anchoTrama-out').innerHTML = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateAnchoTrama(this.value);
	};

	document.getElementById('lineas').change = function(){ 
		col = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateLineas(col);
	};

	document.getElementById('fondo').change = function(){ 
		col = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateFondo(col);
	};

	$('#fondo').minicolors();
	$('#lineas').minicolors();
}; 

/*
$('#zoom').oninput();
$('#anchoTrama').oninput();
$('#anchoTrazo').oninput();
*/
