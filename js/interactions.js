function $(id) { return document.getElementById(id); }

onload = function() {

	$('anchoTrazo').oninput = function(){ 
		$('anchoTrazo-out').innerHTML = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateAnchoTrazo(this.value);
	};

	$('anchoTrama').oninput = function(){ 
		$('anchoTrama-out').innerHTML = this.value;
		var pjs = Processing.getInstanceById('PaperLager');
		pjs.updateAnchoTrama(this.value);
	};
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
	// document.write('<img src="'+canvas+'"/>');
}

$('zoom').oninput();
$('anchoTrama').oninput();
$('anchoTrazo').oninput();